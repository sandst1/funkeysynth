import Qt 4.7

Rectangle {
    id: operator
    signal attackChanged(int value)
    signal decayChanged(int value)
    signal sustainChanged(int value)
    signal releaseChanged(int value)
    signal modFactChanged(int value)
    signal stateChanged(int value)
    signal volumeChanged(int value)

    width: controls.childrenRect.width + 10
    height: controls.childrenRect.height

    property string name: "-1"

    color: "#00000000"

    function enableFreqMod() {
        modfactor.visible = true
    }

    function setVolume(volume) {
        controls.volumeSlider.setValue(volume);
    }

    Row {
        id: controls
        anchors.centerIn: parent
        spacing: 10

        property alias volumeSlider: volume

        Slider {
            id: attack
            name: "Attack(ms)"
            max: 1000
            onValueChanged: { operator.attackChanged(value) }
        }
        Slider {
            id: decay
            name: "Decay(ms)"
            max: 1000
            onValueChanged: { operator.decayChanged(value) }
        }
        Slider {
            id: sustain
            name: "Sustain"
            max: 100
            onValueChanged: { operator.sustainChanged(value) }
        }
        Slider {
            id: release
            name: "Release(ms)"
            max: 2000
            onValueChanged: { operator.releaseChanged(value) }
        }
        Slider {
            id: volume
            name: "Volume"
            max: 100
            onValueChanged: { operator.volumeChanged(value) }
        }

        Slider {
            id: modfactor
            name: "Mod. factor"
            max: 10
            visible: false
            onValueChanged: { operator.modFactChanged(value) }
        }

        Oscillator {
            id: osc
            anchors.verticalCenter: parent.verticalCenter
            onStateChanged: { operator.stateChanged(value) }
            name: operator.name
        }
    }
}
