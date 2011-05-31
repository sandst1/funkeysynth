import Qt 4.7

Rectangle {
    id: textRect
    width: 80
    height: 80
    anchors.margins: 10
    color: "#000000"
    radius: 5
    property string text: "Default"

    border.color: "#3952ED"
    border.width: 2

    Text {
        text: textRect.text
        color: "#FFFFFF"
        anchors.centerIn: parent
    }
}
