import Qt 4.7


Rectangle {
    id: container
    width: (theEnvelope.width + lfoControls.width)*1.05
    anchors.bottom: parent.bottom
    color: "#000000"
    radius: 5
    border.color: "#3952ED"
    border.width: 2

    state: "hidden"
    x: -800

    function toggle() {
        if (state == "hidden") {
            container.state = "visible";
        } else {
            container.state = "hidden";
        }
    }

    Operator {
        id: theEnvelope
        name: "1"
        anchors.verticalCenter: parent.verticalCenter

        onAttackChanged: { Operator1.setAttack(value) }
        onDecayChanged: { Operator1.setDecay(value) }
        onSustainChanged: { Operator1.setSustain(value) }
        onReleaseChanged: { Operator1.setRelease(value) }
        onStateChanged: { Operator1.setWaveType(value) }
        onVolumeChanged: { Operator1.setVolume(value) }
    }

    Row {
        id: lfoControls
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: theEnvelope.right
        spacing: 10
        anchors.leftMargin: 5
        Slider {
            id: lfoFreq
            name: "LFOFreq"
            max: 30
            onValueChanged: {
                LFO.setFreq(value)
            }
        }

        Slider {
            id: lfoAmount
            name: "LFOAmount"
            max: 100
            onValueChanged: {
                LFO.setAmp(value);
                if (value == 0) {
                    LFO.setState(false);
                } else {
                    LFO.setState(true);
                }
            }
        }
    }

    states: [
        State {
            name: "hidden"
            PropertyChanges {
                target: container
                x: -800

            }
        },
        State {
            name: "visible"
            PropertyChanges {
                target: container
                x: 0
            }
        }
    ]

    transitions: [
        Transition {
            from: "hidden"
            to: "visible"
            reversible: true
            NumberAnimation {
                properties: "x";
                duration: 200
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

        theEnvelope.setVolume(75);
    }
}
