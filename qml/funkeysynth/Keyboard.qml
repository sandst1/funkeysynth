import Qt 4.7

Rectangle {
    id: container
    width: parent.width
    height: parent.height / 2

    state: "play"

    color: "#00000000"

    function toggle() {
        if (state == "play") {
            state = "settings"
        } else {
            state = "play"
        }
    }

    Row {
        id: keyboard
        spacing: 1
        width: parent.width
        height: parent.height

        // C1
        WhiteKey {
            id: key0
            keyNum: 0
        }
        WhiteKey {
            id: key1
            keyNum: 1
        }
        WhiteKey {
            id: key2
            keyNum: 2
        }
        WhiteKey {
            id: key3
            keyNum: 3
        }
        WhiteKey {
            id: key4
            keyNum: 4
        }
        WhiteKey {
            id: key5
            keyNum: 5
        }
        WhiteKey {
            id: key6
            keyNum: 6
        }
        // C2
        WhiteKey {
            id: key12
            keyNum: 12
        }
        WhiteKey {
            id: key13
            keyNum: 13
        }
        WhiteKey {
            id: key14
            keyNum: 14
        }
        WhiteKey {
            id: key15
            keyNum: 15
        }
        WhiteKey {
            id: key16
            keyNum: 16
        }
        WhiteKey {
            id: key17
            keyNum: 17
        }
        WhiteKey {
            id: key18
            keyNum: 18
        }
        // C3
        WhiteKey {
            id: key24
            keyNum: 24
        }
        WhiteKey {
            id: key25
            keyNum: 25
        }
        WhiteKey {
            id: key26
            keyNum: 26
        }
        WhiteKey {
            id: key27
            keyNum: 27
        }
        WhiteKey {
            id: key28
            keyNum: 28
        }
        // Cis1
        BlackKey {
            id: key7
            keyNum: 7
            anchors.horizontalCenter: key0.right
        }
        BlackKey {
            id: key8
            keyNum: 8
            anchors.horizontalCenter: key1.right
        }
        BlackKey {
            id: key9
            keyNum: 9
            anchors.horizontalCenter: key3.right
        }
        BlackKey {
            id: key10
            keyNum: 10
            anchors.horizontalCenter: key4.right
        }
        BlackKey {
            id: key11
            keyNum: 11
            anchors.horizontalCenter: key5.right
        }
        // Cis2
        BlackKey {
            id: key19
            keyNum: 19
            anchors.horizontalCenter: key12.right
        }
        BlackKey {
            id: key20
            keyNum: 20
            anchors.horizontalCenter: key13.right
        }
        BlackKey {
            id: key21
            keyNum: 21
            anchors.horizontalCenter: key15.right
        }
        BlackKey {
            id: key22
            keyNum: 22
            anchors.horizontalCenter: key16.right
        }
        BlackKey {
            id: key23
            keyNum: 23
            anchors.horizontalCenter: key17.right
        }
        // Cis3
        BlackKey {
            id: key31
            keyNum: 31
            anchors.horizontalCenter: key24.right
        }
        BlackKey {
            id: key32
            keyNum: 32
            anchors.horizontalCenter: key25.right
        }
        BlackKey {
            id: key33
            keyNum: 33
            anchors.horizontalCenter: key27.right
        }
    }

    MouseArea {
        id: playarea

        property Key currentKey

        anchors.fill: parent
        onPressed: {
            var key = keyboard.childAt(mouseX, mouseY);
            key.press();
            playarea.currentKey = key;
            PlayControl.pressKey();
        }

        onPositionChanged: {
            var key = keyboard.childAt(mouseX, mouseY);
            if (key != null && key.keyNum != playarea.currentKey.keyNum) {
                playarea.currentKey.release();
                key.press();
                playarea.currentKey = key;
            }

            Wah.setWahFreq((((playarea.y + playarea.height) - mouseY)/(playarea.height))*2000 + 400);
            SynthControl.setBendAmount((((playarea.y + playarea.height) - mouseY)/(playarea.height))*75);

        }

        onReleased: {
            if (playarea.currentKey != null) {
                playarea.currentKey.release();
                playarea.currentKey = null
            }
            PlayControl.releaseKey();
        }
    }

    states: [
        State {
            name: "play"
            PropertyChanges {
                target: container
                height: parent.height / 2

            }
        },
        State {
            name: "settings"
            PropertyChanges {
                target: container
                height: 250
            }
        }
    ]

    transitions: [
        Transition {
            from: "play"
            to: "settings"
            reversible: true
            NumberAnimation {
                properties: "height";
                duration: 400
            }
        }
    ]

}
