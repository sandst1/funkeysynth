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
