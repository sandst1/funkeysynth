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
import com.meego 1.0

Rectangle {
    id: container
    width: parent.width
    height: parent.height

    state: "play"

    color: "#00000000"

    function toggle() {
        if (state == "play") {
            state = "settings"
        } else {
            state = "play"
        }
    }

    Row {
        id: keyboard
        spacing: 1
        width: parent.width
        height: parent.height

        // C1
        WhiteKey {
            id: key0
            keyNum: 0
        }
        WhiteKey {
            id: key1
            keyNum: 1
        }
        WhiteKey {
            id: key2
            keyNum: 2
        }
        WhiteKey {
            id: key3
            keyNum: 3
        }
        WhiteKey {
            id: key4
            keyNum: 4
        }
        WhiteKey {
            id: key5
            keyNum: 5
        }
        WhiteKey {
            id: key6
            keyNum: 6
        }
        // C2
        WhiteKey {
            id: key12
            keyNum: 12
        }

        // Cis1
        BlackKey {
            id: key7
            keyNum: 7
            anchors.horizontalCenter: key0.right
        }
        BlackKey {
            id: key8
            keyNum: 8
            anchors.horizontalCenter: key1.right
        }
        BlackKey {
            id: key9
            keyNum: 9
            anchors.horizontalCenter: key3.right
        }
        BlackKey {
            id: key10
            keyNum: 10
            anchors.horizontalCenter: key4.right
        }
        BlackKey {
            id: key11
            keyNum: 11
            anchors.horizontalCenter: key5.right
        }
    }

    TouchArea {
        id: playarea
        anchors.fill: parent

        minimumTouches: 1
        maximumTouches: 2

        touchPoints: [
            KeyTouchPoint {
                id: touch1
                index: 0
                currentKey: null
            },
            KeyTouchPoint {
                id: touch2
                index: 1
                currentKey: null
            }
        ]

        onTouchStart: {
            //console.log("ontouchStart, amount of touches: " + playarea.touches.length);
            for (var i=0; i < playarea.touches.length; i++) {
                var touch = playarea.touches[i];
                var key = keyboard.childAt(touch.x, touch.y);
                key.press();
                touch.currentKey = key;
                PlayControl.pressKey(key.keyNum, touch.index);
            }
        }

        onTouchMove: {
            //console.log("ontouchMove, amount of touches: " + playarea.changedTouches.length);
            for (var i=0; i < playarea.changedTouches.length; i++) {
                var touch = playarea.changedTouches[i];
                var key = keyboard.childAt(touch.x, touch.y);
                if (key != null && key.keyNum != touch.currentKey.keyNum) {
                    touch.currentKey.release();
                    PlayControl.releaseKey(touch.currentKey.keyNum, touch.index);
                    key.press();
                    touch.currentKey = key;
                    PlayControl.sustainKey(key.keyNum, touch.index);
                }

                Wah.setWahFreq((((playarea.y + playarea.height) - touch.y)/(playarea.height))*2000 + 400);
                SynthControl.setBendAmount((((playarea.y + playarea.height) - touch.y)/(playarea.height))*75, touch.index);

            }
        }

        onTouchEnd: {
            //console.log("ontouchEnd, amount of touches: " + playarea.releasedTouches.length);
            for (var i=0; i < playarea.releasedTouches.length; i++) {
                var touch = playarea.releasedTouches[i];
                var key = keyboard.childAt(touch.x, touch.y);
                key.release();
                PlayControl.releaseKey(key.keyNum, touch.index);
                touch.currentKey = null;
            }
        }
    }

 /*   MouseArea {
        id: playarea

        property Key currentKey

        anchors.fill: parent
        onPressed: {
            var key = keyboard.childAt(mouseX, mouseY);
            key.press();
            playarea.currentKey = key;
            PlayControl.pressKey(key.keyNum);
        }

        onPositionChanged: {
            var key = keyboard.childAt(mouseX, mouseY);
            if (key != null && key.keyNum != playarea.currentKey.keyNum) {                
                playarea.currentKey.release();
                PlayControl.releaseKey(playarea.currentKey.keyNum);
                key.press();
                playarea.currentKey = key;

                PlayControl.pressKey(key.keyNum);
            }

            Wah.setWahFreq((((playarea.y + playarea.height) - mouseY)/(playarea.height))*2000 + 400);
            SynthControl.setBendAmount((((playarea.y + playarea.height) - mouseY)/(playarea.height))*75);

        }

        onReleased: {
            var key = keyboard.childAt(mouseX, mouseY);
            key.release();
            PlayControl.releaseKey(key.keyNum);
            playarea.currentKey = null;
        }
    }*/

    states: [
        State {
            name: "play"
            PropertyChanges {
                target: container
                height: parent.height * 0.8

            }
        },
        State {
            name: "settings"
            PropertyChanges {
                target: container
                height: parent.height * 0.2
            }
        }
    ]

    transitions: [
        Transition {
            from: "play"
            to: "settings"
            reversible: true
            NumberAnimation {
                properties: "height";
                duration: 400
            }
        }
    ]

}
