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
#include "reverb.h"

Reverb::Reverb(QObject *parent) :
    Effect(parent), m_buffer(), m_bufferFilled(false), m_bufferIdx(0)
{
}

void Reverb::apply(float& sample)
{
    if (m_on)
    {
        m_buffer[m_bufferIdx] = sample;
        if (m_bufferFilled)
        {
            sample = m_buffer[m_bufferIdx] +
                     0.83*m_buffer[(m_bufferIdx - 1600  + REVERB_SIZE) % REVERB_SIZE] +
                     0.81*m_buffer[(m_bufferIdx - 1792  + REVERB_SIZE) % REVERB_SIZE] +
                     0.79*m_buffer[(m_bufferIdx - 1952  + REVERB_SIZE) % REVERB_SIZE] +
                     0.77*m_buffer[(m_bufferIdx - 2176  + REVERB_SIZE) % REVERB_SIZE] +
                     0.75*m_buffer[(m_bufferIdx - 2304  + REVERB_SIZE) % REVERB_SIZE];
            sample *= (1.0/4.95);
            m_bufferIdx++;
            if (m_bufferIdx >= REVERB_SIZE )
                m_bufferIdx = 0;
        }
        else
        {
            m_bufferIdx++;
            if ( m_bufferIdx >= REVERB_SIZE)
            {
                m_bufferIdx = 0;
                m_bufferFilled = true;
            }
        }
    }

}
