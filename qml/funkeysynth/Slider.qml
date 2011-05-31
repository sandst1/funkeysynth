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
