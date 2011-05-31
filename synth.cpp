/*
 * FunkeySynth - A synthesizer application for MeeGo tablets
 * Copyright (C) 2011 Topi Santakivi <topi.santakivi@gmail.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
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

float Synth::m_freq = 0.00;

Synth::Synth(QDeclarativeContext* context, QObject *parent) :
    QObject(parent), m_key(KEY_C), m_octaveFactor(8), m_index(0), m_periodInSamples(0), m_pitchBend(false), m_bendAmount(0)
{
    m_operators[0] = new Operator(this);
    m_operators[1] = new Operator(this);
    m_operators[2] = new Operator(this);
    m_operators[3] = new Operator(this);

    m_operators[1]->setFollowsKeys(true);
    m_operators[2]->setFollowsKeys(true);
    m_operators[3]->setFollowsKeys(true);

    context->setContextProperty("Operator1", m_operators[0]);
    context->setContextProperty("Operator2", m_operators[1]);
    context->setContextProperty("Operator3", m_operators[2]);
    context->setContextProperty("Operator4", m_operators[3]);

    m_effects = new Effects(context, this);
    context->setContextProperty("Effects", m_effects);

    m_lfo = new LFO(this);
    context->setContextProperty("LFO", m_lfo);
}

void Synth::keyPressed()
{
    m_index = 0;
    for (int i = 0; i < AMOUNT_OF_OPERATORS; i++)
    {
        m_operators[i]->keyPressed();
    }
}

void Synth::keyReleased()
{
    for (int i = 0; i < AMOUNT_OF_OPERATORS; i++)
    {
        m_operators[i]->keyReleased();
    }
}

void Synth::setKey(Key key)
{
    m_key = key;
    m_freq = m_octaveFactor*(pow(2, (int)key/KEYS_IN_OCTAVE))*FREQZTABLE[(int)key % KEYS_IN_OCTAVE];
    m_periodInSamples = (int)((float)SAMPLE_RATE / (m_freq));
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
    if (state == false )
    {
        m_freq = m_octaveFactor*(pow(2, (int)m_key/KEYS_IN_OCTAVE))*FREQZTABLE[(int)m_key % KEYS_IN_OCTAVE];
        m_periodInSamples = (int)((float)SAMPLE_RATE / (m_freq));
    }
}

void Synth::setBendAmount(int bend)
{
    m_bendAmount = bend;
}

// ENDOF SynthControl interface

float Synth::snd()
{
    float sample = 0.0;
    m_index++;
    if (m_index>=m_periodInSamples)
        m_index = 0;

    if (m_pitchBend)
    {
        m_freq = m_octaveFactor*(pow(2, (int)m_key/KEYS_IN_OCTAVE));
        float b = ((float)m_bendAmount/100);
        float a = 1.0 - b;
        m_freq *= (a*FREQZTABLE[(int)m_key % KEYS_IN_OCTAVE] + b*FREQZTABLE[((int)m_key+1) % KEYS_IN_OCTAVE]);
        m_periodInSamples = (int)((float)SAMPLE_RATE / (m_freq));

    }

    float wc = 2.0*M_PI*((float)(m_freq)/SAMPLE_RATE);

    sample = m_operators[0]->snd(wc*m_index +
                                m_operators[1]->snd(m_operators[1]->modFactor()*wc*(float)m_index - M_PI_PER2) +
                                m_operators[2]->snd(m_operators[2]->modFactor()*wc*(float)m_index - M_PI_PER2) +
                                m_operators[3]->snd(m_operators[3]->modFactor()*wc*(float)m_index - M_PI_PER2) +
                                m_lfo->snd() - M_PI_PER2);

    m_effects->apply(sample);

    return sample;

}
