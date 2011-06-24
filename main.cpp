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
#include <QtGui/QApplication>
#include <QDeclarativeContext>
#include <QDesktopWidget>
#include "qmlapplicationviewer.h"
#include <QGLFormat>
#include <QGLWidget>
#include <QMutex>

#include "audiocontrol.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QApplication::setGraphicsSystem("opengl");

    QDeclarativeView* view = new QDeclarativeView();

    QGLFormat format = QGLFormat::defaultFormat();
    format.setSampleBuffers(false);

    QGLWidget* glWidget = new QGLWidget(format, view);
    glWidget->setAutoFillBackground(false);

    QDeclarativeContext* context = view->rootContext();

    AudioControl audioControl(context);
    audioControl.start();

    QMutex& waitAudio = audioControl.getStartLock();
    qDebug("main::waiting for Audio thread to initialize");
    waitAudio.lock();
    qDebug("main::Audio thread initialized, setting up qml window");
    waitAudio.unlock();

    QRect screenSize = app.desktop()->screenGeometry();
    context->setContextProperty("ScreenWidth", screenSize.width());
    context->setContextProperty("ScreenHeight", screenSize.height());
    context->setContextProperty("PlayControl", &audioControl);

    view->setViewport(glWidget);
    view->setSource(QUrl("qrc:/qml/funkeysynth/main.qml"));
    view->setResizeMode(QDeclarativeView::SizeRootObjectToView);
    //qDebug("main::showing qml window");
    //view->showFullScreen();    
    view->showNormal();

    app.exec();

    delete view;

    return 0;
}
