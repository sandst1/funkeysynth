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
#include "audiocontrol.h"

#include <malloc.h>
#include <QApplication>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

static void streamFinished( void* userData )
{
   (void) userData;
}

static int audioCallback(const void *inputBuffer, void *outputBuffer,
                         unsigned long framesPerBuffer,
                         const PaStreamCallbackTimeInfo* timeInfo,
                         PaStreamCallbackFlags statusFlags,
                         void *userData )
{
    Synth* synth = (Synth*)userData;    

    float *out = (float*)outputBuffer;
    unsigned long i;

    (void) timeInfo;
    (void) statusFlags;
    (void) inputBuffer;

    for( i=0; i<framesPerBuffer; i++ )
    {
        *out++ = synth->snd();
        *out++ = *(out-1);
    }

    return paContinue;
}

AudioControl::AudioControl(QDeclarativeContext* context, QObject *parent) :
    QThread(parent), m_startLock()
{
    m_startLock.lock();
    m_qmlContext = context;

    m_releaseTimer = new QTimer();
    connect(m_releaseTimer, SIGNAL(timeout()), this, SLOT(releaseNow()));
    m_releaseTimer->setSingleShot(true);
}

QMutex& AudioControl::getStartLock()
{
    return m_startLock;
}


void AudioControl::run()
{
    PaError err;

    m_synth = new Synth(m_qmlContext);
    if (m_qmlContext != NULL)
    {
        m_qmlContext->setContextProperty("SynthControl", m_synth);
    }

    err = initPortAudio();

    if (err != paNoError )
      terminateAudioStream(err);

    m_startLock.unlock();
    exec();

    stopAudioStream();
    delete m_releaseTimer;
    delete m_synth;

    QApplication::quit();
}

/****** QML PlayControl interface *****/

void AudioControl::setKey(int key)
{
    // TODO: add a prevKey instead of 0!
    m_synth->setKey((Synth::Key)key, (Synth::Key)0);
}

void AudioControl::pressKey(int key)
{
    m_synth->keyPressed((Synth::Key)key);
    Pa_StartStream(m_audioStream);
}

void AudioControl::releaseKey(int key)
{    
    m_synth->keyReleased((Synth::Key)key);
}

void AudioControl::exitApp()
{
    this->quit();
}

/******* ENDOF PlayControl interface *****/


void AudioControl::releaseNow()
{
    Pa_StopStream(m_audioStream);
}


void AudioControl::stopAudioStream()
{
    PaError err = Pa_StopStream( m_audioStream );
    if( err != paNoError )
    {
        qDebug("Error stopping stream!");
        Pa_Terminate();
        return;
    }

    err = Pa_CloseStream( m_audioStream );
    if( err != paNoError )
    {
        qDebug("Error stopping stream!");
        Pa_Terminate();
    }
}

void AudioControl::terminateAudioStream(PaError err)
{
    qDebug("terminateAudioStream");
    Pa_Terminate();
    qDebug( "An error occured while using the portaudio stream\n" );
    qDebug( "Error number: %d\n", err );
    qDebug( "Error message: %s\n", Pa_GetErrorText( err ) );
}

PaError AudioControl::initPortAudio()
{
    qDebug("AudioControl::initPortAudio");
    PaStreamParameters outputParameters;
    PaError err;

    err = Pa_Initialize();
    if( err != paNoError )
        return err;

    qDebug("AudioControl::Pa initialized successfully");

    outputParameters.device = Pa_GetDefaultOutputDevice(); /* default output device */
    if (outputParameters.device == paNoDevice) {
        fprintf(stderr,"Error: No default output device.\n");
        err = paInvalidDevice;
        return err;
    }

    qDebug("AudioControl::output device got");

    outputParameters.channelCount = 2;       /* stereo output */
    outputParameters.sampleFormat = paFloat32; /* 32 bit floating point output */
    outputParameters.suggestedLatency = 0.05;//Pa_GetDeviceInfo( outputParameters.device )->defaultLowOutputLatency;
    outputParameters.hostApiSpecificStreamInfo = NULL;

    qDebug("AudioControl::opening PaStream");
    err = Pa_OpenStream(
              &m_audioStream,
              NULL, /* no input */
              &outputParameters,
              SAMPLE_RATE,
              FRAMES_PER_BUFFER,
              paClipOff,      /* we won't output out of range samples so don't bother clipping them */
              audioCallback,
              m_synth );
    if( err != paNoError )
        return err;


    qDebug("AudioControl::stream opened");
    err = Pa_SetStreamFinishedCallback( m_audioStream, &streamFinished );


    qDebug("AudioControl::initPortAudio done, returning");

    return err;
}



