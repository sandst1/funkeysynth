import Qt 4.7

Rectangle {
    width: 1368
    height: 768
    //width: ScreenWidth
    //height: ScreenHeight

    gradient: Gradient {
        GradientStop { position: 0.0; color: "#000C58" }
        GradientStop { position: 0.7; color: "#3952ED" }
        GradientStop { position: 1.0; color: "white" }
    }

    MainControls {
        id: mainControls
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: controlButtons.left
//        x: controlButtons.x + width/2
    }

    ControlButtons {
        id: controlButtons
        anchors.bottomMargin: 10
        anchors.bottom: keyboard.top
    }

    Modulators {
        id: modulators
        y: 10
        x: 10
    }

    Keyboard {
        id: keyboard
        anchors.bottom: parent.bottom
        anchors.left:  parent.left
    }

    Component.onCompleted: {
    }
}
