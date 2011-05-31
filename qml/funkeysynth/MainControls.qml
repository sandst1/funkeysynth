import Qt 4.7

Rectangle {
    id: container
    state: "visible"

    color: "#00000000"

    width: mainOperator.width
    height: mainOperator.height

    function toggle() {
        if (state == "visible") {
            state = "hidden"
        } else {
            state = "visible"
        }
    }

    Operator {
        id: mainOperator
        visible: true
        anchors.margins: 10
        name: "1"

        onAttackChanged: { Operator1.setAttack(value) }
        onDecayChanged: { Operator1.setDecay(value) }
        onSustainChanged: { Operator1.setSustain(value) }
        onReleaseChanged: { Operator1.setRelease(value) }
        onStateChanged: { Operator1.setWaveType(value) }
        onVolumeChanged: { Operator1.setVolume(value) }
    }

    LFO {
        anchors.left: mainOperator.right
        anchors.top: parent.top
        anchors.margins: 10
        anchors.verticalCenter: mainOperator.verticalCenter
    }


    states: [
        State {
            name: "visible"
            PropertyChanges {
                target: container
                opacity: 1
            }
        },
        State {
            name: "hidden"
            PropertyChanges {
                target: container
                opacity: 0
            }
        }
    ]

    transitions: [
        Transition {
            from: "visible"
            to: "hidden"
            reversible: true
            PropertyAnimation {
                target: container
                properties: "opacity"
                duration: 500
            }
        }
    ]

    Component.onCompleted: {
        Operator1.setAttack(0)
        Operator1.setDecay(0)
        Operator1.setSustain(100)
        Operator1.setRelease(0)
        Operator1.setModFactor(1);
        Operator1.setVolume(75);

        mainOperator.setVolume(75);
    }
}
