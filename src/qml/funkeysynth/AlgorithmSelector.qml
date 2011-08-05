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
    property int algorithm: 0

    property string imagePath: "../../images/alg0.png"

    border.color: "#3952ED"
    border.width: 2

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
        onPressed: {
            button.algorithm++;
            if (button.algorithm == 6) {
                button.algorithm = 0;
            }

            SynthControl.setAlgorithm(button.algorithm);
            button.imagePath = "../../images/alg" + button.algorithm + ".png";
        }
    }
}
