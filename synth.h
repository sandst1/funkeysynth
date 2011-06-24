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
#ifndef SYNTH_H
#define SYNTH_H

#include <QDeclarativeContext>
#include <QMap>
#include <QObject>

#include <math.h>
#include "constants_types.h"
#include "effects.h"
#include "lfo.h"
#include "operator.h"

#define AMOUNT_OF_OPERATORS 4

class Synth : public QObject
{
    Q_OBJECT
public:
    enum Key
    {
        KEY_C = 0,
        KEY_D,
        KEY_E,
        KEY_F,
        KEY_G,
        KEY_A,
        KEY_B,
        KEY_CIS,
        KEY_DIS,
        KEY_FIS,
        KEY_GIS,
        KEY_BB,
        KEY_C2,
        KEY_D2,
        KEY_E2,
        KEY_F2,
        KEY_G2,
        KEY_A2,
        KEY_B2,
        KEY_CIS2,
        KEY_DIS2,
        KEY_FIS2,
        KEY_GIS2,
        KEY_BB2,
        KEY_C3,
        KEY_D3,
        KEY_E3,
        KEY_F3,
        KEY_G3,
        KEY_CIS3 = KEY_CIS2+KEYS_IN_OCTAVE,
        KEY_DIS3,
        KEY_FIS3,
        KEY_NONE
    };

    explicit Synth(QDeclarativeContext* context, QObject *parent = 0);

    void keyPressed(Key key, unsigned int index);
    void keyReleased(Key key, unsigned int index);

    //void setKey(Key key, Key prevKey, unsigned int index);

    int releaseTime();
    float releaseStep();

    // SynthControl interface
    Q_INVOKABLE void octaveUp();
    Q_INVOKABLE void octaveDown();
    Q_INVOKABLE void setBend(bool state);
    Q_INVOKABLE void setBendAmount(int bend, unsigned int index);

    float snd();

signals:

public slots:
    void freeKey(unsigned int index);
private:
    struct KeyData {
        Key key;
        int index;
        float freq;
        int periodInSamples;
        int phase;
        int bendAmount;
    };

    KeyData* getFreeKey();
    KeyData* getKeyData(const Key& key);

    KeyData m_pressedKeys[2];

    int m_octaveFactor;    

    Operator* m_operators[AMOUNT_OF_OPERATORS];

    Effects* m_effects;
    LFO* m_lfo;

    bool m_pitchBend;
};

#endif // SYNTH_H
