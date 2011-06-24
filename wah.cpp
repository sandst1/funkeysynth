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
#include "constants_types.h"
#include "wah.h"

Wah::Wah(QObject *parent) :
    Effect(parent), m_F1(0), m_damp(0.10), m_Yh(0), m_Yb(0), m_Yl(0)
{
}

void Wah::apply(float& sample)
{
    if (m_on)
    {
        m_Yh = sample - m_Yl - m_damp*m_Yb;
        m_Yb = m_F1*m_Yh + m_Yb;
        m_Yl = m_F1*m_Yb + m_Yl;

        sample = m_Yb;
    }
}

void Wah::setWahFreq(float freq)
{
    m_freq = freq;
    m_F1 = 2*sin((M_PI*m_freq)/SAMPLE_RATE);
}
