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
#ifndef OPERATOR_H
#define OPERATOR_H

#include <QObject>


class Operator : public QObject
{
    Q_OBJECT
public:
    explicit Operator(QObject *parent = 0);

    enum WaveType
    {
        SINE,
        SQUARE,
        SAW,
        TRIANGLE,
        NOISE
    };

    enum EnvelopeState
    {
        ENV_ATTACK,
        ENV_DECAY,
        ENV_SUSTAIN,
        ENV_RELEASE,
        ENV_IDLE
    };

    struct EnvelopeSettings
    {
        int   attackTime; // ms
        int   decayTime; // ms
        int   releaseTime; // ms

        float attackStep; // fractions / sample
        float decayStep; // fractions / sample
        float releaseStep; // fractions / sample

        float sustainLevel; // volume level
    };

    struct Envelope
    {
        EnvelopeState state;
        float amp;
    };

    // QML control interface
    Q_INVOKABLE void setWaveType(int waveType);
    Q_INVOKABLE void setAttack(int attack);
    Q_INVOKABLE void setDecay(int decay);
    Q_INVOKABLE void setSustain(int sustain);
    Q_INVOKABLE void setRelease(int release);
    Q_INVOKABLE void setModFactor(int modfactor);
    Q_INVOKABLE void setVolume(int volume);

    // Interface for the Synth
    float snd(float wphase, unsigned int envelope);

    void envelopeAttack(unsigned int envelope);
    void envelopeRelease(unsigned int envelope);
    void envelopeSustain(unsigned int envelope);

    int releaseTime();
    float releaseStep();

    void setFollowsKeys(bool value);
    bool followsKeys();
    float modFactor();

    void reset(unsigned int envelope);

    Envelope& getEnvelope(unsigned int index);

signals:
    void soundDone(unsigned int envelope);
public slots:

private:
    void calculateEnvelope();

    void updateEnvelopeState(unsigned int envelope);
    int m_modFactor;

    float m_volume;

    int m_periodInSamples;
    bool m_followKeys;
    WaveType m_waveType;

    EnvelopeSettings m_envValues;
    Envelope m_envelopes[2];
};

#endif // OPERATOR_H
