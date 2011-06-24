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
    id: slider
    width: 80
    height: 200
    property int range: slider.height-handle.height
    property int max: 1000
    property int value: Math.round(((range-handle.y))*max/(range))
    property string name: "Default"
    signal valueChanged(int value)

    gradient: Gradient {
        GradientStop { position: 0.0; color: "#F63B18" }
        GradientStop { position: 1.0; color: "black" }
    }

    border.width: 2
    border.color: "#000000"
    radius: 10

    function setValue(newvalue) {
        handle.y = slider.range - (slider.range*newvalue)/slider.max;
    }

    Rectangle {
        id: handle
        y: range
        width: 80
        height: 70
        color: "#000000"
        radius: 10
        border.width: 2
        border.color: "#3952ED"

        MouseArea {
            anchors.fill: parent
            drag.target: parent
            drag.axis: "YAxis"
            drag.minimumY: 0
            drag.maximumY: range

            onPressed: {
                handle.color = "#3952ED";
            }

            onPositionChanged: {                
                slider.valueChanged(slider.value)
            }

            onReleased: {
                handle.color = "#000000";
            }
        }

        Text {
            anchors.centerIn: parent
            text: slider.value
            color: "#ffffff"
        }
    }
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: name
        anchors.top: slider.bottom
        anchors.topMargin: 5
        color: "#ffffff"
    }   
}
