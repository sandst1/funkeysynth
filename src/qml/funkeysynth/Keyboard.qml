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
    height: parent.height / 2

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
        WhiteKey {
            id: key13
            keyNum: 13
        }
        WhiteKey {
            id: key14
            keyNum: 14
        }
        WhiteKey {
            id: key15
            keyNum: 15
        }
        WhiteKey {
            id: key16
            keyNum: 16
        }
        WhiteKey {
            id: key17
            keyNum: 17
        }
        WhiteKey {
            id: key18
            keyNum: 18
        }
        // C3
        WhiteKey {
            id: key24
            keyNum: 24
        }
        WhiteKey {
            id: key25
            keyNum: 25
        }
        WhiteKey {
            id: key26
            keyNum: 26
        }
        WhiteKey {
            id: key27
            keyNum: 27
        }
        WhiteKey {
            id: key28
            keyNum: 28
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
        // Cis2
        BlackKey {
            id: key19
            keyNum: 19
            anchors.horizontalCenter: key12.right
        }
        BlackKey {
            id: key20
            keyNum: 20
            anchors.horizontalCenter: key13.right
        }
        BlackKey {
            id: key21
            keyNum: 21
            anchors.horizontalCenter: key15.right
        }
        BlackKey {
            id: key22
            keyNum: 22
            anchors.horizontalCenter: key16.right
        }
        BlackKey {
            id: key23
            keyNum: 23
            anchors.horizontalCenter: key17.right
        }
        // Cis3
        BlackKey {
            id: key31
            keyNum: 31
            anchors.horizontalCenter: key24.right
        }
        BlackKey {
            id: key32
            keyNum: 32
            anchors.horizontalCenter: key25.right
        }
        BlackKey {
            id: key33
            keyNum: 33
            anchors.horizontalCenter: key27.right
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

    MouseArea {
        id: mousePlayArea

        property Key currentKey

        anchors.fill: parent
        onPressed: {
            var key = keyboard.childAt(mouseX, mouseY);
            key.press();
            mousePlayArea.currentKey = key;
            PlayControl.pressKey(key.keyNum, 0);
        }

        onPositionChanged: {
            var key = keyboard.childAt(mouseX, mouseY);
            if (key != null && key.keyNum != mousePlayArea.currentKey.keyNum) {
                mousePlayArea.currentKey.release();
                PlayControl.releaseKey(mousePlayArea.currentKey.keyNum, 0);
                key.press();
                mousePlayArea.currentKey = key;

                PlayControl.sustainKey(key.keyNum, 0);
            }

            Wah.setWahFreq((((mousePlayArea.y + mousePlayArea.height) - mouseY)/(mousePlayArea.height))*2000 + 400);
            SynthControl.setBendAmount((((mousePlayArea.y + mousePlayArea.height) - mouseY)/(mousePlayArea.height))*75, 0);

        }

        onReleased: {
            var key = keyboard.childAt(mouseX, mouseY);
            key.release();
            PlayControl.releaseKey(key.keyNum, 0);
            mousePlayArea.currentKey = null;
        }
    }

    states: [
        State {
            name: "play"
            PropertyChanges {
                target: container
                height: parent.height / 2

            }
        },
        State {
            name: "settings"
            PropertyChanges {
                target: container
                height: 250
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
