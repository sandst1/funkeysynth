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
#ifndef LFO_H
#define LFO_H

#include <QObject>
#include "constants_types.h"

class LFO : public QObject
{
    Q_OBJECT
public:
    explicit LFO(QObject *parent = 0);

    Q_INVOKABLE void setState(bool state);
    Q_INVOKABLE void setAmp(int amp);
    Q_INVOKABLE void setFreq(int freq);

    float snd();
    float freq();

signals:

public slots:

private:
    bool m_on;
    float m_amp;
    int m_freq;
    int m_periodInSamples;
    int m_index;

};

#endif // LFO_H
