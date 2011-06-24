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

#include "lfo.h"

LFO::LFO(QObject *parent) :
    QObject(parent), m_on(false), m_freq(0), m_periodInSamples(0), m_index(0)
{
}

void LFO::setState(bool state)
{
    m_on = state;
}

void LFO::setAmp(int amp)
{
    m_amp = (float)amp/100;
}

void LFO::setFreq(int freq)
{
    m_freq = freq;
    m_periodInSamples = (int)((float)SAMPLE_RATE / (m_freq+1));
    m_index = 0;
}

float LFO::snd()
{
    if (m_on)
    {
        m_index++;
        if (m_index >= m_periodInSamples)
            m_index = 0;

        float wc = 2.0*M_PI*((float)(m_freq)/SAMPLE_RATE);
        return m_amp*sin(wc*m_index);
    }
    return 0.00;
}

float LFO::freq()
{
    return (float)m_freq;
}
