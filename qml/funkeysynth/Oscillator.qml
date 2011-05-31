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
