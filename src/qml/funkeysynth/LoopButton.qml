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
    id: button
    width: 80
    height: 80
    anchors.margins: 10
    color: "#000000"
    radius: 5
    state: "rec"

    signal waitingForNotes()
    signal loopReady()
    signal loopPlay()
    signal loopStop()

    property color  normalColor: "#000000"
    property color  pressedColor: "#3952ED"
    property string imagePath: "../../images/rec.png"

    border.color: "#3952ED"
    border.width: 2

    function startRecording() {
        button.state = "recgoing"
    }

    function loopFull() {
        button.state = "loopready"
    }

    Text {
        id: buttonText
        text: "Loop"
        color: "#FFFFFF"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.margins: 10
    }

    Item {
        id: imgContainer
        width: icon.width
        height: icon.height
        anchors.horizontalCenter: buttonText.horizontalCenter
        anchors.top: buttonText.bottom
        anchors.margins: 5
        Image {
            id: icon
            source: button.imagePath
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (button.state == "rec") {
                button.state = "recpause";
                button.waitingForNotes();
            } else if (button.state == "recgoing") {
                button.state = "loopready";
                button.loopReady();
            } else if (button.state == "loopready") {
                button.state = "playing";
                button.loopPlay();
            } else if (button.state == "playing") {
                button.state = "loopready";
                button.loopStop();
            } else if (button.state == "") {
                button.state = "";
            }
        }

        onPressAndHold: {
            if (button.state == "loopready") {
                button.state = "rec"
            }
        }
    }

    states: [
        State {
            name: "rec"
            PropertyChanges {
                target: button
                color: normalColor
                imagePath: "../../images/rec.png"
            }
        },
        State {
            name: "recpause"
            PropertyChanges {
                target: button
                color: pressedColor
                imagePath: "../../images/recpause.png"
            }
        },
        State {
            name: "recgoing"
            PropertyChanges {
                target: button
                color: pressedColor
                imagePath: "../../images/rec.png"
            }
        },
        State {
            name: "loopready"
            PropertyChanges {
                target: button
                color: pressedColor
                imagePath: "../../images/play.png"
            }
        },
        State {
            name: "playing"
            PropertyChanges {
                target: button
                color: pressedColor
                imagePath: "../../images/playpause.png"
            }
        }
    ]

    transitions: [
        Transition {
            from: "rec"
            to: "recpause"
            reversible: true
            PropertyAnimation {
                properties: "color";
                duration: 250
            }
        },
        Transition {
            from: "loopready"
            to: "rec"
            PropertyAnimation {
                properties: "color";
                duration: 250
            }
        }
    ]
}
