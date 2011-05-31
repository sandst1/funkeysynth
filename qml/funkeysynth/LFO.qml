import Qt 4.7

Rectangle {
    id: lfo
    color: "#00000000"

    property int lfoFreq: 0
    property bool increasingFreq: false

    width: lfoGrid.childrenRect.width
    height: lfoGrid.childrenRect.height

    Grid {
        id: lfoGrid
        rows: 2
        columns: 2

        TextRectangle {
            text: lfo.lfoFreq
        }
        Button {
            id: lfotoggle
            text: "LFO"
            text2: "LFO"
            property bool lfoOn: false
            onClicked: {
                if (lfoOn) {
                    lfoOn = false;
                } else {
                    lfoOn = true;
                }
                LFO.setState(lfoOn);
            }
        }

        SingleStateButton {
            text: "-"
            onClicked: {
                lfo.lfoFreq = (lfo.lfoFreq == 0) ? 0 : lfo.lfoFreq-1;
                LFO.setFreq(lfo.lfoFreq);
            }

            onPressAndHold: {
                lfo.increasingFreq = false;
                freqTimer.start();
            }

            onReleased: {
                freqTimer.stop();
            }
        }
        SingleStateButton {
            text: "+"
            onClicked: {
                lfo.lfoFreq++;
                LFO.setFreq(lfo.lfoFreq);
            }

            onPressAndHold: {
                lfo.increasingFreq = true;
                freqTimer.start();
            }

            onReleased: {
                freqTimer.stop();
            }
        }
    }

    Slider {
        id: lfoVolume
        height: lfo.height
        anchors.left: lfoGrid.right
        anchors.top: lfoGrid.top
        anchors.leftMargin: 5
        name: "Amp"

        max: 100

        onValueChanged: {
            LFO.setAmp(value);
        }
    }

    function timerCallback() {
        if (lfo.increasingFreq) {
            lfo.lfoFreq++;
        } else {
            lfo.lfoFreq = (lfo.lfoFreq == 0) ? 0 : lfo.lfoFreq-1;
        }
        LFO.setFreq(lfo.lfoFreq);
    }

    Timer {
        id: freqTimer;
        interval: 100; running: false; repeat: true;
        onTriggered: timerCallback();
    }
}

