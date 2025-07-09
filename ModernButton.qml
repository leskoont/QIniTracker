import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {
    id: button

    property string text: "Button"
    property string iconText: ""
    property color buttonColor: "#7c3aed"
    property color textColor: "white"
    property bool enabled: true

    signal clicked()

    width: 120
    height: 40
    radius: 12


    gradient: Gradient {
        GradientStop {
            position: 0.0;
            color: button.enabled ? (mouseArea.pressed ? Qt.darker(buttonColor, 1.3) :
                                    mouseArea.containsMouse ? Qt.lighter(buttonColor, 1.1) : buttonColor) : Qt.darker(buttonColor, 1.5)
        }
        GradientStop {
            position: 1.0;
            color: button.enabled ? (mouseArea.pressed ? Qt.darker(buttonColor, 1.5) :
                                    mouseArea.containsMouse ? buttonColor : Qt.darker(buttonColor, 1.2)) : Qt.darker(buttonColor, 1.7)
        }
    }

    border.width: 1
    border.color: button.enabled ? Qt.lighter(buttonColor, 1.2) : Qt.darker(buttonColor, 1.3)

    opacity: button.enabled ? 1.0 : 0.6


    Rectangle {
        anchors.fill: parent
        anchors.margins: -2
        radius: parent.radius + 2
        color: "transparent"
        border.width: 1
        border.color: Qt.rgba(0, 0, 0, 0.1)
        z: -1
        visible: !mouseArea.pressed
    }


    Rectangle {
        anchors.fill: parent
        anchors.margins: 1
        radius: parent.radius - 1
        color: "transparent"
        border.width: 1
        border.color: Qt.rgba(255, 255, 255, mouseArea.containsMouse ? 0.3 : 0.15)
        visible: button.enabled
    }


    Row {
        anchors.centerIn: parent
        spacing: iconText !== "" ? 8 : 0


        Text {
            text: iconText
            color: textColor
            font.pixelSize: 16
            visible: iconText !== ""
            anchors.verticalCenter: parent.verticalCenter
        }


        Text {
            text: button.text
            color: textColor
            font.pixelSize: 13
            font.weight: Font.Medium
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
        }
    }


    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: button.enabled
        hoverEnabled: true

        onClicked: button.clicked()
    }


    Behavior on opacity {
        NumberAnimation { duration: 150 }
    }


    NumberAnimation {
        id: pressAnimation
        target: button
        property: "scale"
        to: 0.95
        duration: 100
        running: mouseArea.pressed
    }

    NumberAnimation {
        id: releaseAnimation
        target: button
        property: "scale"
        to: 1.0
        duration: 100
        running: !mouseArea.pressed
    }


    SequentialAnimation {
        id: pulseAnimation
        running: false
        loops: Animation.Infinite

        NumberAnimation {
            target: button
            property: "scale"
            to: 1.05
            duration: 800
        }
        NumberAnimation {
            target: button
            property: "scale"
            to: 1.0
            duration: 800
        }
    }


    Component.onCompleted: {
        if (text === "Next Turn") {
            pulseAnimation.running = true
        }
    }

    onTextChanged: {
        pulseAnimation.running = (text === "Next Turn")
    }
}
