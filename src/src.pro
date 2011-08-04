TARGET = funkeysynth
# Add more folders to ship with the application, here
#folder_01.source = qml/funkeysynth
#folder_01.target = qml
#DEPLOYMENTFOLDERS = folder_01

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
    lfo.cpp \
    qdeclarativetoucharea.cpp

PACKAGENAME = com.sandst1.funkeysynth

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/myqmlapplicationviewer.pri)
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
    lfo.h \
    qdeclarativetoucharea.h

OTHER_FILES += \
    qml/funkeysynth/WhiteKey.qml \
    qml/funkeysynth/TextRectangle.qml \
    qml/funkeysynth/Slider.qml \
    qml/funkeysynth/SingleStateButton.qml \
    qml/funkeysynth/Oscillator.qml \
    qml/funkeysynth/Operator.qml \
    qml/funkeysynth/Modulators.qml \
    qml/funkeysynth/MainControls.qml \
    qml/funkeysynth/main.qml \
    qml/funkeysynth/LFO.qml \
    qml/funkeysynth/Keyboard.qml \
    qml/funkeysynth/Key.qml \
    qml/funkeysynth/ControlButtons.qml \
    qml/funkeysynth/Button.qml \
    qml/funkeysynth/BlackKey.qml \
    qml/funkeysynth/KeyTouchPoint.qml \
    qml/funkeysynth/MainEnvelope.qml \
    qml/funkeysynth/LoopButton.qml \
    qml/funkeysynth/SubEnvelopes.qml \
    qml/funkeysynth/ModsWindow.qml

unix {
  #VARIABLES
  isEmpty(PREFIX) {
    PREFIX = /usr
  }
  BINDIR = $$PREFIX/bin
  DATADIR =$$PREFIX/share

  DEFINES += DATADIR=\\\"$$DATADIR\\\" PKGDATADIR=\\\"$$PKGDATADIR\\\"

  #MAKE INSTALL

  INSTALLS += target

  target.path =$$BINDIR

  #desktop.path = $$DATADIR/applications/hildon
  #desktop.files += $${TARGET}.desktop

  #service.path = $$DATADIR/dbus-1/services
  #service.files += $${TARGET}.service

  #icon16.files = ../data/16x16/funkeysynth.png
  #icon16.path = /usr/share/icons/hicolor/16x16/apps
  #INSTALLS += icon16
  #icon32.files = ../data/32x32/funkeysynth.png
  #icon32.path = /usr/share/icons/hicolor/32x32/apps
  #INSTALLS += icon32
  icon64.files = ../funkeysynth.png
  icon64.path = /usr/share/icons/hicolor/64x64/apps
  INSTALLS += icon64
  #icon128.files = ../data/128x128/funkeysynth.png
  #icon128.path = /usr/share/icons/hicolor/128x128/apps
  #INSTALLS += icon128
}
