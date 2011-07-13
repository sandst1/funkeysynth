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

Column {
    spacing: 20
    id: container

    property string name: "-1"

    signal stateChanged(int value)

    Rectangle {
        id: oscillator
        width: 80
        height: 80
        color: "#000000"
        border.color: "#3952ED"
        border.width: 2

        radius: 10
        property int curState: 0
        property string name: "-1"

        Text {
            id: textId
            text: "Sine"
            color: "#FFFFFF"
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent            
            onPressed: {
                oscillator.color = "#3952ED"
                oscillator.curState++;
                if (oscillator.curState == 5)
                    oscillator.curState = 0;

                container.stateChanged(oscillator.curState);

                switch (oscillator.curState) {
                case 0:
                    textId.text = "Sine";
                    break;
                case 1:
                    textId.text = "Square";
                    break;
                case 2:
                    textId.text = "Saw";
                    break;
                case 3:
                    textId.text = "Triangle";
                    break;
                case 4:
                    textId.text = "Noise";
                    break;
                default:
                    break;
                }
            }

            onReleased: {
                oscillator.color = "#000000"
            }
        }
    }

    Rectangle {
        width: 60
        height: 60

        radius: 10
        color: "#000000"        
        border.width: 2
        border.color: "#3952ED"

        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            color: "#ffffff"
            anchors.centerIn: parent
            text: container.name
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 32
        }
    }
}
