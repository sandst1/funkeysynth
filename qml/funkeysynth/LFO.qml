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
    id: lfo
    color: "#00000000"

    property int lfoFreq: 0
    property bool increasingFreq: false

    width: lfoGrid.childrenRect.width
    height: lfoGrid.childrenRect.height

    Grid {
        id: lfoGrid
        rows: 2
        columns: 2

        TextRectangle {
            text: lfo.lfoFreq
        }
        Button {
            id: lfotoggle
            text: "LFO"
            text2: "LFO"
            property bool lfoOn: false
            onClicked: {
                if (lfoOn) {
                    lfoOn = false;
                } else {
                    lfoOn = true;
                }
                LFO.setState(lfoOn);
            }
        }

        SingleStateButton {
            text: "-"
            onClicked: {
                lfo.lfoFreq = (lfo.lfoFreq == 0) ? 0 : lfo.lfoFreq-1;
                LFO.setFreq(lfo.lfoFreq);
            }

            onPressAndHold: {
                lfo.increasingFreq = false;
                freqTimer.start();
            }

            onReleased: {
                freqTimer.stop();
            }
        }
        SingleStateButton {
            text: "+"
            onClicked: {
                lfo.lfoFreq++;
                LFO.setFreq(lfo.lfoFreq);
            }

            onPressAndHold: {
                lfo.increasingFreq = true;
                freqTimer.start();
            }

            onReleased: {
                freqTimer.stop();
            }
        }
    }

    Slider {
        id: lfoVolume
        height: lfo.height
        anchors.left: lfoGrid.right
        anchors.top: lfoGrid.top
        anchors.leftMargin: 5
        name: "Amp"

        max: 100

        onValueChanged: {
            LFO.setAmp(value);
        }
    }

    function timerCallback() {
        if (lfo.increasingFreq) {
            lfo.lfoFreq++;
        } else {
            lfo.lfoFreq = (lfo.lfoFreq == 0) ? 0 : lfo.lfoFreq-1;
        }
        LFO.setFreq(lfo.lfoFreq);
    }

    Timer {
        id: freqTimer;
        interval: 100; running: false; repeat: true;
        onTriggered: timerCallback();
    }
}

