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

Row {
    id: buttonsRow
    spacing: 10
    state: "normal"

    function toggle() {
        if (state == "normal") {
            state = "settings"
        } else {
            state = "normal"
        }
    }

    Button {
        id: wah
        text: "Wah"
        text2: "Wah"
        onClicked: {
            if (wah.state == "state1") {
                Effects.setWah(false);
            } else {
                Effects.setWah(true);
            }
        }
    }
    /*Button {
        id: reverb
        text: "Reverb"
        text2: "Reverb"
        onClicked: {
            if (reverb.state == "state1") {
                Effects.setReverb(false);
            } else {
                Effects.setReverb(true);
            }
        }
    }
    Button {
        id: phaser
        text: "Phaser"
        text2: "Phaser"
        onClicked: {

        }
    }
    Button {
        id: flanger
        text: "Flanger"
        text2: "Flanger"
        onClicked: {

        }
    }*/
    Button {
        id: bend
        text: "Bend"
        text2: "Bend"
        onClicked: {
            if (bend.state == "state1") {
                SynthControl.setBend(false);
            } else {
                SynthControl.setBend(true);
            }
        }
    }

    SingleStateButton {
        text: "oct -"
        onClicked: {
            SynthControl.octaveDown();
        }
    }
    SingleStateButton {
        text: "oct +"
        onClicked: {
            SynthControl.octaveUp();
        }
    }

    Button {
        id: settingsButton

        text: "Mods"
        text2: "Main"

        onClicked: {
            keyboard.toggle();
            //modulators.toggle();
            //mainControls.toggle();
            buttonsRow.toggle();
        }
    }

    LoopButton {
        id: loopButton
        onWaitingForNotes: {
            SynthControl.recordLoop();
        }

        onLoopReady: {
            SynthControl.stopRecording();
        }

        onLoopPlay: {
            SynthControl.playLoop();
        }

        onLoopStop: {
            SynthControl.stopLoop();
        }

        Connections {
            target: SynthControl
            onRecordingStarted: {
                loopButton.startRecording();
            }

            onLoopBufferFull: {
                loopButton.loopFull();
            }
        }
    }

    Button {
        id: closeButton
        text: "Exit"
        text2: "Exit"

        onClicked: {
            PlayControl.exitApp();
        }
    }

    states: [
        State {
            name: "normal"
            PropertyChanges {
                target: buttonsRow
                x: 10
            }
        },
        State {
            name: "settings"
            PropertyChanges {
                target: buttonsRow
                x: buttonsRow.parent.width - buttonsRow.width - 10
            }
        }
    ]

    transitions: [
        Transition {
            from: "normal"
            to: "settings"
            reversible: true
            PropertyAnimation {
                properties: "x";
                duration: 400
            }
        }
    ]
}
