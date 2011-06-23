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
