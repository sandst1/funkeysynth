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
    id: key
    color: "#000000"
    state: "idle"
    property int keyNum: 0
    property color color_normal: "#000000"
    property color color_pressed: "#000C58"

    function press() {
        key.state = "pressed";
    }

    function release() {
        key.state = "idle";
        key.color = key.color_normal;
    }

    states: [
        State {
            name: "idle"
            PropertyChanges {
                target: key
                color: color_normal
            }
        },
        State {
            name: "pressed"
            PropertyChanges {
                target: key
                color: color_pressed
            }
        }
    ]
}
