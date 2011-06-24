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
#ifndef AudioControl_H
#define AudioControl_H

#include <QDeclarativeContext>
#include <QMutex>
#include <QThread>
#include <QTimer>
#include <portaudio.h>

#include "constants_types.h"
#include "synth.h"

class AudioControl : public QThread
{
    Q_OBJECT
public:
    explicit AudioControl(QDeclarativeContext* context, QObject *parent = 0);

    QMutex& getStartLock();

    void run();

    // QML interface
    Q_INVOKABLE virtual void setKey(int key);
    Q_INVOKABLE virtual void pressKey(int key);
    Q_INVOKABLE virtual void releaseKey(int key);
    Q_INVOKABLE virtual void exitApp();

signals:

public slots:
    void releaseNow();
private:
    void stopAudioStream();
    void terminateAudioStream(PaError err);
    QMutex m_startLock;
    PaError initPortAudio();

    PaStream* m_audioStream;

    Synth* m_synth;
    QTimer* m_releaseTimer;
    QDeclarativeContext* m_qmlContext;
};

#endif // AudioControl_H
