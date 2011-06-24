/*
 * FunkeySynth - A synthesizer application for MeeGo tablets
 * Copyright (C) 2011 Topi Santakivi <topi.santakivi@gmail.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 3
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */
#include <math.h>
#include <QFile>
#include "synth.h"

Synth::Synth(QDeclarativeContext* context, QObject *parent) :
    QObject(parent), m_pressedKeys(), m_octaveFactor(8), m_pitchBend(false), m_bendAmount(0)
{
    m_operators[0] = new Operator(this);
    m_operators[1] = new Operator(this);
    m_operators[2] = new Operator(this);
    m_operators[3] = new Operator(this);

    m_operators[1]->setFollowsKeys(true);
    m_operators[2]->setFollowsKeys(true);
    m_operators[3]->setFollowsKeys(true);

    //qDebug("Synth::setting context properties for operators&effects");
    context->setContextProperty("Operator1", m_operators[0]);
    context->setContextProperty("Operator2", m_operators[1]);
    context->setContextProperty("Operator3", m_operators[2]);
    context->setContextProperty("Operator4", m_operators[3]);

    m_effects = new Effects(context, this);
    context->setContextProperty("Effects", m_effects);

    m_lfo = new LFO(this);
    context->setContextProperty("LFO", m_lfo);

    m_pressedKeys[0].key = KEY_NONE;
    m_pressedKeys[0].index = 0;
    m_pressedKeys[0].freq = 0.00;
    m_pressedKeys[0].periodInSamples = 0;
    m_pressedKeys[1].key = KEY_NONE;
    m_pressedKeys[1].index = 1;
    m_pressedKeys[1].freq = 0.00;
    m_pressedKeys[1].periodInSamples = 0;

    connect(m_operators[0], SIGNAL(soundDone(uint)), this, SLOT(freeKey(uint)));
}

void Synth::keyPressed(Key key)
{

    KeyData* keyData = getFreeKey();
    if (keyData != NULL)
    {
        keyData->freq = m_octaveFactor*(pow(2, (int)key/KEYS_IN_OCTAVE))*FREQZTABLE[(int)key % KEYS_IN_OCTAVE];
        keyData->periodInSamples = (int)((float)SAMPLE_RATE / (keyData->freq));
        keyData->key = key;
        keyData->phase = 0;

        for (int i = 0; i < AMOUNT_OF_OPERATORS; i++)
        {
            m_operators[i]->envelopeAttack(keyData->index);
        }
    }
    else
    {
        qDebug("Synth::keyPressed ERROR: KeyData is NULL!!");
    }
}

void Synth::keyReleased(Key key)
{
    KeyData* keyData = getKeyData(key);
    if (keyData != NULL)
    {
        for (int i = 0; i < AMOUNT_OF_OPERATORS; i++)
        {
            m_operators[i]->envelopeRelease(keyData->index);
        }
    }
    else
    {
        qDebug("Synth::keyReleased ERROR: KeyData is NULL!!");
    }
}

void Synth::setKey(Key key, Key prevKey)
{
    //m_key = key;
    //m_freq = m_octaveFactor*(pow(2, (int)key/KEYS_IN_OCTAVE))*FREQZTABLE[(int)key % KEYS_IN_OCTAVE];
    //m_periodInSamples = (int)((float)SAMPLE_RATE / (m_freq));
}

int Synth::releaseTime()
{
    return m_operators[0]->releaseTime();
}

float Synth::releaseStep()
{
    return m_operators[0]->releaseStep();
}


// SynthControl interface
void Synth::octaveUp()
{
    if (m_octaveFactor <= 16)
        m_octaveFactor *= 2;
}

void Synth::octaveDown()
{
    if (m_octaveFactor >= 4)
        m_octaveFactor /= 2;
}

void Synth::setBend(bool state)
{
    m_pitchBend = state;
    // TODO: Take current key into account!
    /*if (state == false )
    {
        m_freq = m_octaveFactor*(pow(2, (int)m_key/KEYS_IN_OCTAVE))*FREQZTABLE[(int)m_key % KEYS_IN_OCTAVE];
        m_periodInSamples = (int)((float)SAMPLE_RATE / (m_freq));
    }*/
}

void Synth::setBendAmount(int bend)
{
    m_bendAmount = bend;
}

// ENDOF SynthControl interface

float Synth::snd()
{
    int phase = 0;
    float sample = 0.0;
    float wc = 0.0;

    /*if (m_pitchBend)
    {
        m_freq = m_octaveFactor*(pow(2, (int)m_key/KEYS_IN_OCTAVE));
        float b = ((float)m_bendAmount/100);
        float a = 1.0 - b;
        m_freq *= (a*FREQZTABLE[(int)m_key % KEYS_IN_OCTAVE] + b*FREQZTABLE[((int)m_key+1) % KEYS_IN_OCTAVE]);
        m_periodInSamples = (int)((float)SAMPLE_RATE / (m_freq));

    }*/

    m_pressedKeys[0].phase++;
    if (m_pressedKeys[0].phase>=m_pressedKeys[0].periodInSamples)
        m_pressedKeys[0].phase = 0;

    phase = m_pressedKeys[0].phase;
    wc = 2.0*M_PI*((float)(m_pressedKeys[0].freq)/SAMPLE_RATE);
    sample = m_operators[0]->snd(wc*phase +
                                m_operators[1]->snd(m_operators[1]->modFactor()*wc*(float)phase - M_PI_PER2, 0) +
                                m_operators[2]->snd(m_operators[2]->modFactor()*wc*(float)phase - M_PI_PER2, 0) +
                                m_operators[3]->snd(m_operators[3]->modFactor()*wc*(float)phase - M_PI_PER2, 0) +
                                m_lfo->snd() - M_PI_PER2, 0);

    m_pressedKeys[1].phase++;
    if (m_pressedKeys[1].phase>=m_pressedKeys[1].periodInSamples)
        m_pressedKeys[1].phase = 0;

    phase = m_pressedKeys[1].phase;
    wc = 2.0*M_PI*((float)(m_pressedKeys[1].freq)/SAMPLE_RATE);
    sample += m_operators[0]->snd(wc*phase +
                                m_operators[1]->snd(m_operators[1]->modFactor()*wc*(float)phase - M_PI_PER2, 1) +
                                m_operators[2]->snd(m_operators[2]->modFactor()*wc*(float)phase - M_PI_PER2, 1) +
                                m_operators[3]->snd(m_operators[3]->modFactor()*wc*(float)phase - M_PI_PER2, 1) +
                                m_lfo->snd() - M_PI_PER2, 1);

    m_effects->apply(sample);

    return sample;

}

void Synth::freeKey(unsigned int index)
{
    qDebug("Synth::freeKey %u", index);
    if (index <= 1)
    {
        m_pressedKeys[index].key = KEY_NONE;
        m_operators[1]->reset(index);
        m_operators[2]->reset(index);
        m_operators[3]->reset(index);
    }
}

Synth::KeyData* Synth::getFreeKey()
{
    if (m_pressedKeys[0].key == KEY_NONE)
    {
        qDebug("synth::getFreeKey 0");
        return &(m_pressedKeys[0]);
    }
    else if (m_pressedKeys[1].key == KEY_NONE)
    {
        qDebug("synth::getFreeKey 1");
        return &(m_pressedKeys[1]);
    }

    if (m_operators[0]->getEnvelope(0).amp < m_operators[0]->getEnvelope(1).amp)
    {
        m_operators[0]->reset(0);
        m_operators[1]->reset(0);
        m_operators[2]->reset(0);
        m_operators[3]->reset(0);
        return &(m_pressedKeys[0]);
    }
    else
    {
        m_operators[0]->reset(1);
        m_operators[1]->reset(1);
        m_operators[2]->reset(1);
        m_operators[3]->reset(1);
        return &(m_pressedKeys[1]);
    }


    qDebug("synth::getFreeKey NULL");
    return NULL;
}

Synth::KeyData* Synth::getKeyData(const Key& key)
{
    if (m_pressedKeys[0].key == key)
    {
        qDebug("synth::getKeyData 0");
        return &(m_pressedKeys[0]);
    }
    else if (m_pressedKeys[1].key == key)
    {
        qDebug("synth::getKeyData 1");
        return &(m_pressedKeys[1]);
    }
    qDebug("synth::getKeyData NULL");
    return NULL;

}
