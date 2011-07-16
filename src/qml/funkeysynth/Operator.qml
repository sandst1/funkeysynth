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
    id: operator
    signal attackChanged(int value)
    signal decayChanged(int value)
    signal sustainChanged(int value)
    signal releaseChanged(int value)
    signal modFactChanged(int value)
    signal stateChanged(int value)
    signal volumeChanged(int value)

    width: controls.childrenRect.width + 10
    height: controls.childrenRect.height

    property string name: "-1"

    color: "#00000000"

    function enableFreqMod() {
        modfactor.visible = true
    }

    function setVolume(volume) {
        controls.volumeSlider.setValue(volume);
    }

    Row {
        id: controls
        anchors.centerIn: parent
        spacing: 10

        property alias volumeSlider: volume

        Slider {
            id: attack
            name: "Attack(ms)"
            max: 1000            
            onValueChanged: { operator.attackChanged(value) }
        }
        Slider {
            id: decay
            name: "Decay(ms)"
            max: 1000
            onValueChanged: { operator.decayChanged(value) }
        }
        Slider {
            id: sustain
            name: "Sustain"
            max: 100
            onValueChanged: { operator.sustainChanged(value) }
        }
        Slider {
            id: release
            name: "Release(ms)"
            max: 2000
            onValueChanged: { operator.releaseChanged(value) }
        }
        Slider {
            id: volume
            name: "Volume"
            max: 100
            onValueChanged: { operator.volumeChanged(value) }
        }

        Slider {
            id: modfactor
            name: "Mod. factor"
            max: 10
            visible: false
            onValueChanged: { operator.modFactChanged(value) }
        }

        Oscillator {
            id: osc
            anchors.verticalCenter: parent.verticalCenter
            anchors.centerIn: parent
            onStateChanged: { operator.stateChanged(value) }
            visible: false
            name: operator.name
        }
    }
}
