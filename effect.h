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
#ifndef EFFECT_H
#define EFFECT_H

#include <QObject>
#define EFFECTS_AMOUNT 4

class Effect : public QObject
{
    Q_OBJECT
public:
    enum EffectType
    {
        WAH,
        REVERB,
        PHASER,
        FLANGER
    };

    explicit Effect(QObject *parent = 0);
    virtual ~Effect() {}

    void setState(bool state);

    virtual void apply(float& sample) = 0;

signals:

public slots:

protected:
    bool m_on;

};

#endif // EFFECT_H
