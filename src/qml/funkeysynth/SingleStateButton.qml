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
    state: "state1"

    signal clicked()
    signal pressAndHold()
    signal released()

    property string text: "Default"
    property color  normalColor: "#000000"
    property color  pressedColor: "#3952ED"

    border.width: 2
    border.color: "#3952ED"

    Text {
        id: buttonText
        text: button.text
        color: "#FFFFFF"
        anchors.centerIn: parent
    }
    MouseArea {
        anchors.fill: parent
        onPressed: {
            button.clicked();
            button.color = pressedColor;
        }

        onPressAndHold: {
            button.pressAndHold();
        }

        onReleased: {
            button.color = normalColor;
            button.released();
        }
    }
}