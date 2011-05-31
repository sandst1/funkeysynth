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
#ifndef EFFECTS_H
#define EFFECTS_H

#include <QObject>
#include "QDeclarativeContext"
#include "effect.h"

class Effects : public QObject
{
    Q_OBJECT
public:
    explicit Effects(QDeclarativeContext* context, QObject *parent = 0);
    ~Effects();

    // QML Control interface
    Q_INVOKABLE void setWah(bool state);
    Q_INVOKABLE void setReverb(bool state);
    Q_INVOKABLE void setPhaser(bool state);
    Q_INVOKABLE void setFlanger(bool state);

    void apply(float& sample);

signals:

public slots:

private:
    Effect* m_effects[EFFECTS_AMOUNT];
};

#endif // EFFECTS_H
