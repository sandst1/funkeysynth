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
    property string text: "Default"
    property string text2: "Default2"
    property string currentText: text
    property color  normalColor: "#000000"
    property color  pressedColor: "#3952ED"
    property alias buttonText: buttonText

    border.color: "#3952ED"
    border.width: 2

    Text {
        id: buttonText
        text: button.currentText
        color: "#FFFFFF"
        anchors.centerIn: parent
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {            
            if (button.state == "state1") {
                button.state = "state2"
            } else {
                button.state = "state1"
            }
            button.clicked();
        }
    }

    states: [
        State {
            name: "state1"
            PropertyChanges {
                target: button
                currentText: button.text
                color: normalColor
            }
        },
        State {
            name: "state2"
            PropertyChanges {
                target: button
                currentText: button.text2
                color: pressedColor
            }
        }
    ]

    transitions: [
        Transition {
            from: "state1"
            to: "state2"
            reversible: true
            PropertyAnimation {
                properties: "color";
                duration: 250
            }
        }
    ]
}
