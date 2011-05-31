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
#ifndef WAH_H
#define WAH_H

#include "effect.h"

class Wah : public Effect
{
    Q_OBJECT
public:
    explicit Wah(QObject *parent = 0);

    void apply(float& sample);

    Q_INVOKABLE void setWahFreq(float freq);

signals:

public slots:

private:
    float m_freq;
    float m_F1;
    float m_damp;
    float m_Yh;
    float m_Yb;
    float m_Yl;



};

#endif // WAH_H
