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
import QtQuick 1.0

Rectangle {
    id: container
    height: operator2.height
    width: operator2.width
    color: "#00000000"
    //state: "visible"
    //x: -800

    /*function toggle() {
        if (state == "hidden") {
            container.state = "visible";
        } else {
            container.state = "hidden";
        }
    }*/

    Column {
        id: opSelector
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: operator2.left

        Button {
            id: selectOp2
            text: "osc2"
            text2: "osc2"
            state: "state2"

            onClicked: {                               
                operator2.state = "visible";
                operator3.state = "hidden";
                operator4.state = "hidden";

                selectOp3.state = "state1";
                selectOp4.state = "state1";
            }
        }

        Button {
            id: selectOp3
            text: "osc3"
            text2: "osc3"

            onClicked: {
                operator2.state = "hidden";
                operator3.state = "visible";
                operator4.state = "hidden";
                selectOp2.state = "state1";
                selectOp4.state = "state1";
            }
        }

        Button {
            id: selectOp4
            text: "osc4"
            text2: "osc4"

            onClicked: {
                operator2.state = "hidden";
                operator3.state = "hidden";
                operator4.state = "visible";
                selectOp2.state = "state1";
                selectOp3.state = "state1";
            }
        }
    }

    Operator {
        id: operator2
        name: "2"
        anchors.centerIn: parent
        state: "visible"

        onAttackChanged: { Operator2.setAttack(value) }
        onDecayChanged: { Operator2.setDecay(value) }
        onSustainChanged: { Operator2.setSustain(value) }
        onReleaseChanged: { Operator2.setRelease(value) }
        onModFactChanged: { Operator2.setModFactor(value) }
        onStateChanged: { Operator2.setWaveType(value) }
        onVolumeChanged: { Operator2.setVolume(value) }
    }

    Operator {
        id: operator3
        name: "3"
        anchors.centerIn: parent
        state: "hidden"

        onAttackChanged: { Operator3.setAttack(value) }
        onDecayChanged: { Operator3.setDecay(value) }
        onSustainChanged: { Operator3.setSustain(value) }
        onReleaseChanged: { Operator3.setRelease(value) }
        onModFactChanged: { Operator3.setModFactor(value) }
        onStateChanged: { Operator3.setWaveType(value) }
        onVolumeChanged: { Operator3.setVolume(value) }
    }

    Operator {
        id: operator4
        name: "4"
        anchors.centerIn: parent
        state: "hidden"

        onAttackChanged: { Operator4.setAttack(value) }
        onDecayChanged: { Operator4.setDecay(value) }
        onSustainChanged: { Operator4.setSustain(value) }
        onReleaseChanged: { Operator4.setRelease(value) }
        onModFactChanged: { Operator4.setModFactor(value) }
        onStateChanged: { Operator4.setWaveType(value) }
        onVolumeChanged: { Operator4.setVolume(value) }
    }

    Component.onCompleted: {
        Operator2.setAttack(0)
        Operator2.setDecay(0)
        Operator2.setSustain(100)
        Operator2.setRelease(0)
        Operator2.setModFactor(1);

        Operator3.setAttack(0)
        Operator3.setDecay(0)
        Operator3.setSustain(100)
        Operator3.setRelease(0)
        Operator3.setModFactor(1);

        Operator4.setAttack(0)
        Operator4.setDecay(0)
        Operator4.setSustain(100)
        Operator4.setRelease(0)
        Operator4.setModFactor(1);

        operator2.enableFreqMod();
        operator3.enableFreqMod();
        operator4.enableFreqMod();

        operator2.enableOsc();
        operator3.enableOsc();
        operator4.enableOsc();

        selectOp2.denyManualDisable();
        selectOp3.denyManualDisable();
        selectOp4.denyManualDisable();
    }
}
