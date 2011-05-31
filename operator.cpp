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
#include <stdlib.h>
#include "constants_types.h"
#include "operator.h"

#include <QThread>

Operator::Operator(QObject *parent) :
    QObject(parent), m_amp(1.00), m_modFactor(1), m_volume(0.00), m_periodInSamples(0), m_followKeys(true), m_waveType(SINE)
{
}

// QML interface
void Operator::setWaveType(int waveType)
{
    m_waveType = (WaveType)waveType;
}

void Operator::setAttack(int attack)
{
    if (attack == 0)
        attack = 1;
    m_envelope.attackTime = attack;
    calculateEnvelope();
}

void Operator::setDecay(int decay)
{
    if (decay == 0)
        decay = 1;
    m_envelope.decayTime = decay;
    calculateEnvelope();
}

void Operator::setSustain(int sustain)
{
    m_envelope.sustainLevel = (float)sustain/100;
    calculateEnvelope();
}

void Operator::setRelease(int release)
{
    if (release == 0)
        release = 1;
    m_envelope.releaseTime = release;
    calculateEnvelope();
}

void Operator::setModFactor(int modfactor)
{
    if (modfactor == 0)
        modfactor = 1;
    m_modFactor = modfactor;
}

void Operator::setVolume(int volume)
{
    m_volume = (float)volume/100;
}

// ENDOF QML interface

float Operator::snd(float wphase)
{
    float output = 0.00;

    switch (m_waveType)
    {
        case SINE:
            output = sin(wphase);
        break;

        case SQUARE:
            if ( wphase <= M_PI )
                output = 1.0;
            else
                output = -1.0;
        break;

        case SAW:
            if ( wphase <= M_PI )
            {
                output = (wphase/M_PI);
            }
            else
            {
                output = (-2.0 + (wphase/M_PI));
            }
        break;

        case TRIANGLE:
            if ( wphase <= M_PI )
            {
                output = (wphase/M_PI);
            }
            else
            {
                output = (2.0 - (wphase/M_PI));
            }
        break;

        case NOISE:
            output = (rand()/(float)RAND_MAX)-0.5;
        break;

        default:
        break;
    }

    updateEnvelopeState();

    return output*m_amp*m_volume;
}

void Operator::keyPressed()
{
    m_envelope.state = ENV_ATTACK;
}

void Operator::keyReleased()
{
    m_envelope.state = ENV_RELEASE;
}

int Operator::releaseTime()
{
    return m_envelope.releaseTime;
}

float Operator::releaseStep()
{
    return m_envelope.releaseStep;
}

void Operator::setFollowsKeys(bool value)
{
    m_followKeys = value;
}

bool Operator::followsKeys()
{
    return m_followKeys;
}

float Operator::modFactor()
{
    return m_modFactor;
}























void Operator::calculateEnvelope()
{
    m_envelope.attackStep = 1.00 / (MS_IN_SAMPLES*m_envelope.attackTime+0.00001);
    m_envelope.decayStep  = (1.00-m_envelope.sustainLevel) / (MS_IN_SAMPLES*m_envelope.decayTime+0.00001);
    m_envelope.releaseStep = m_envelope.sustainLevel / (MS_IN_SAMPLES*m_envelope.releaseTime+0.00001);
}

void Operator::updateEnvelopeState()
{
    // Update the envelope
    switch (m_envelope.state)
    {
        case ENV_ATTACK:
            m_amp += m_envelope.attackStep;
            if (m_amp >= 1.00)
            {
                m_envelope.state = ENV_DECAY;
            }
        break;

        case ENV_DECAY:
            m_amp -= m_envelope.decayStep;
            if (m_amp <= m_envelope.sustainLevel)
            {
                m_amp = m_envelope.sustainLevel;
                m_envelope.state = ENV_SUSTAIN;
            }
        break;

        case ENV_SUSTAIN:
        break;

        case ENV_RELEASE:
            m_amp -= m_envelope.releaseStep;
            if (m_amp <= 0)
            {
                m_amp = 0.00;
            }
        break;

        case ENV_IDLE:
        break;

    }
}
