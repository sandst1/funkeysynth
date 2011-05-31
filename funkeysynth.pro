# Add more folders to ship with the application, here
folder_01.source = qml/funkeysynth
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

INCLUDEPATH += /usr/include /usr/include/malloc

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# Define QMLJSDEBUGGER to allow debugging of QML in debug builds
# (This might significantly increase build time)
# DEFINES += QMLJSDEBUGGER

# If your application uses the Qt Mobility libraries, uncomment
# the following lines and add the respective components to the 
# MOBILITY variable. 
# CONFIG += mobility
# MOBILITY +=

QT += core gui declarative opengl

CONFIG += link_pkgconfig
#PKGCONFIG += gstreamer-0.10 gstreamer-interfaces-0.10 gstreamer-app-0.10
LIBS += -lportaudio

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    synth.cpp \
    operator.cpp \
    audiocontrol.cpp \
    effects.cpp \
    effect.cpp \
    wah.cpp \
    reverb.cpp \
    flanger.cpp \
    phaser.cpp \
    lfo.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

RESOURCES += \
    funkeysynth.qrc

HEADERS += \
    constants_types.h \
    synth.h \
    operator.h \
    audiocontrol.h \
    effects.h \
    effect.h \
    wah.h \
    reverb.h \
    flanger.h \
    phaser.h \
    lfo.h
