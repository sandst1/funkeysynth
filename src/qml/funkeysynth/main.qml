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
import Qt 4.7

Rectangle {
    width: 854
    height: 480
    //width: ScreenWidth
    //height: ScreenHeight

    gradient: Gradient {
        GradientStop { position: 0.0; color: "#000C58" }
        GradientStop { position: 0.7; color: "#3952ED" }
        GradientStop { position: 1.0; color: "white" }
    }

    Oscillator {
        id: mainOsc
        //anchors.verticalCenter: parent.verticalCenter
        //anchors.centerIn: parent
        anchors.margins: 10
        anchors.bottom: keyboard.top
        anchors.left: parent.left
        onStateChanged: { Operator1.setWaveType(value); }
        name: operator.name
    }

    ControlButtons {
        id: controlButtons
        anchors.left: mainOsc.right
        anchors.margins: 10
        anchors.bottom: keyboard.top
    }

    /*
    MainControls {
        id: mainControls
        anchors.bottom: keyboard.top
        anchors.right: controlButtons.left
//        x: controlButtons.x + width/2
    }*/

    /*Modulators {
        id: modulators
        y: 10
        x: 10
    }*/

    Keyboard {
        id: keyboard
        anchors.bottom: parent.bottom
        anchors.left:  parent.left
    }

    Component.onCompleted: {
        Operator1.setAttack(0)
        Operator1.setDecay(0)
        Operator1.setSustain(100)
        Operator1.setRelease(0)
        Operator1.setModFactor(1);
        Operator1.setVolume(75);
    }
}
