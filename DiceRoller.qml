import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle {
    id: root
    height: 240
    color: "#24283b"
    radius: 16
    border.width: 1
    border.color: "#30363d"

    property color accentColor: "#f59e0b"
    property color successColor: "#10b981"
    property color dangerColor: "#ef4444"
    property color textPrimary: "#c9d1d9"
    property color textSecondary: "#8b949e"
    property color surfaceColor: "#1a1b26"
    property int lastRoll: 0
    property string lastDice: ""


    Rectangle {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 50
        color: accentColor
        radius: 16

        gradient: Gradient {
            GradientStop { position: 0.0; color: accentColor }
            GradientStop { position: 1.0; color: Qt.darker(accentColor, 1.1) }
        }

        Rectangle {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.radius
            color: accentColor
        }

        Row {
            anchors.centerIn: parent
            spacing: 8

            Text {
                text: "🎲"
                font.pixelSize: 18
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                text: "Dice Roller"
                font.pixelSize: 16
                font.bold: true
                font.weight: Font.Bold
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Column {
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20
        anchors.topMargin: 15
        spacing: 15


        Rectangle {
            width: parent.width
            height: 50
            color: surfaceColor
            radius: 12
            border.width: 1
            border.color: "#30363d"

            Text {
                id: resultText
                anchors.centerIn: parent
                text: lastRoll > 0 ? lastDice + ": " + lastRoll : "Roll a dice!"
                color: textPrimary
                font.pixelSize: 15
                font.weight: Font.Bold
            }
        }


        Grid {
            anchors.horizontalCenter: parent.horizontalCenter
            columns: 4
            spacing: 8


            Rectangle {
                width: 55
                height: 40
                radius: 10
                color: mouseAreaD4.containsMouse ? Qt.lighter(accentColor, 1.2) : accentColor
                border.width: 1
                border.color: Qt.darker(accentColor, 1.3)

                gradient: Gradient {
                    GradientStop { position: 0.0; color: mouseAreaD4.containsMouse ? Qt.lighter(accentColor, 1.2) : accentColor }
                    GradientStop { position: 1.0; color: mouseAreaD4.containsMouse ? accentColor : Qt.darker(accentColor, 1.1) }
                }

                Text {
                    anchors.centerIn: parent
                    text: "d4"
                    color: "white"
                    font.pixelSize: 12
                    font.weight: Font.Bold
                }

                MouseArea {
                    id: mouseAreaD4
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: root.rollDice("d4", 4)
                }

                Behavior on color {
                    ColorAnimation { duration: 150 }
                }
            }


            Rectangle {
                width: 55
                height: 40
                radius: 10
                color: mouseAreaD6.containsMouse ? Qt.lighter(accentColor, 1.2) : accentColor
                border.width: 1
                border.color: Qt.darker(accentColor, 1.3)

                gradient: Gradient {
                    GradientStop { position: 0.0; color: mouseAreaD6.containsMouse ? Qt.lighter(accentColor, 1.2) : accentColor }
                    GradientStop { position: 1.0; color: mouseAreaD6.containsMouse ? accentColor : Qt.darker(accentColor, 1.1) }
                }

                Text {
                    anchors.centerIn: parent
                    text: "d6"
                    color: "white"
                    font.pixelSize: 12
                    font.weight: Font.Bold
                }

                MouseArea {
                    id: mouseAreaD6
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: root.rollDice("d6", 6)
                }

                Behavior on color {
                    ColorAnimation { duration: 150 }
                }
            }


            Rectangle {
                width: 55
                height: 40
                radius: 10
                color: mouseAreaD8.containsMouse ? Qt.lighter(accentColor, 1.2) : accentColor
                border.width: 1
                border.color: Qt.darker(accentColor, 1.3)

                gradient: Gradient {
                    GradientStop { position: 0.0; color: mouseAreaD8.containsMouse ? Qt.lighter(accentColor, 1.2) : accentColor }
                    GradientStop { position: 1.0; color: mouseAreaD8.containsMouse ? accentColor : Qt.darker(accentColor, 1.1) }
                }

                Text {
                    anchors.centerIn: parent
                    text: "d8"
                    color: "white"
                    font.pixelSize: 12
                    font.weight: Font.Bold
                }

                MouseArea {
                    id: mouseAreaD8
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: root.rollDice("d8", 8)
                }

                Behavior on color {
                    ColorAnimation { duration: 150 }
                }
            }


            Rectangle {
                width: 55
                height: 40
                radius: 10
                color: mouseAreaD10.containsMouse ? Qt.lighter(accentColor, 1.2) : accentColor
                border.width: 1
                border.color: Qt.darker(accentColor, 1.3)

                gradient: Gradient {
                    GradientStop { position: 0.0; color: mouseAreaD10.containsMouse ? Qt.lighter(accentColor, 1.2) : accentColor }
                    GradientStop { position: 1.0; color: mouseAreaD10.containsMouse ? accentColor : Qt.darker(accentColor, 1.1) }
                }

                Text {
                    anchors.centerIn: parent
                    text: "d10"
                    color: "white"
                    font.pixelSize: 12
                    font.weight: Font.Bold
                }

                MouseArea {
                    id: mouseAreaD10
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: root.rollDice("d10", 10)
                }

                Behavior on color {
                    ColorAnimation { duration: 150 }
                }
            }


            Rectangle {
                width: 55
                height: 40
                radius: 10
                color: mouseAreaD12.containsMouse ? Qt.lighter(accentColor, 1.2) : accentColor
                border.width: 1
                border.color: Qt.darker(accentColor, 1.3)

                gradient: Gradient {
                    GradientStop { position: 0.0; color: mouseAreaD12.containsMouse ? Qt.lighter(accentColor, 1.2) : accentColor }
                    GradientStop { position: 1.0; color: mouseAreaD12.containsMouse ? accentColor : Qt.darker(accentColor, 1.1) }
                }

                Text {
                    anchors.centerIn: parent
                    text: "d12"
                    color: "white"
                    font.pixelSize: 12
                    font.weight: Font.Bold
                }

                MouseArea {
                    id: mouseAreaD12
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: root.rollDice("d12", 12)
                }

                Behavior on color {
                    ColorAnimation { duration: 150 }
                }
            }


            Rectangle {
                width: 55
                height: 40
                radius: 10
                color: mouseAreaD20.containsMouse ? Qt.lighter("#7c3aed", 1.2) : "#7c3aed"
                border.width: 2
                border.color: Qt.darker("#7c3aed", 1.3)

                gradient: Gradient {
                    GradientStop { position: 0.0; color: mouseAreaD20.containsMouse ? Qt.lighter("#7c3aed", 1.2) : "#7c3aed" }
                    GradientStop { position: 1.0; color: mouseAreaD20.containsMouse ? "#7c3aed" : Qt.darker("#7c3aed", 1.1) }
                }

                Text {
                    anchors.centerIn: parent
                    text: "d20"
                    color: "white"
                    font.pixelSize: 12
                    font.weight: Font.Bold
                }

                MouseArea {
                    id: mouseAreaD20
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: root.rollDice("d20", 20)
                }

                Behavior on color {
                    ColorAnimation { duration: 150 }
                }
            }


            Rectangle {
                width: 55
                height: 40
                radius: 10
                color: mouseAreaD100.containsMouse ? Qt.lighter(accentColor, 1.2) : accentColor
                border.width: 1
                border.color: Qt.darker(accentColor, 1.3)

                gradient: Gradient {
                    GradientStop { position: 0.0; color: mouseAreaD100.containsMouse ? Qt.lighter(accentColor, 1.2) : accentColor }
                    GradientStop { position: 1.0; color: mouseAreaD100.containsMouse ? accentColor : Qt.darker(accentColor, 1.1) }
                }

                Text {
                    anchors.centerIn: parent
                    text: "d100"
                    color: "white"
                    font.pixelSize: 11
                    font.weight: Font.Bold
                }

                MouseArea {
                    id: mouseAreaD100
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: root.rollDice("d100", 100)
                }

                Behavior on color {
                    ColorAnimation { duration: 150 }
                }
            }


            Rectangle {
                width: 55
                height: 40
                radius: 10
                color: mouseAreaClear.containsMouse ? Qt.lighter("#6b7280", 1.2) : "#6b7280"
                border.width: 1
                border.color: "#4b5563"

                Text {
                    anchors.centerIn: parent
                    text: "Clear"
                    color: "white"
                    font.pixelSize: 11
                    font.weight: Font.Bold
                }

                MouseArea {
                    id: mouseAreaClear
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        lastRoll = 0
                        lastDice = ""
                        resultText.text = "Roll a dice!"
                        resultText.color = textPrimary
                    }
                }

                Behavior on color {
                    ColorAnimation { duration: 150 }
                }
            }
        }


        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 12

            Text {
                text: "Modifier:"
                color: textSecondary
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 13
                font.weight: Font.Medium
            }

            Rectangle {
                width: 80
                height: 35
                radius: 8
                color: surfaceColor
                border.width: 1
                border.color: "#30363d"

                TextField {
                    id: modifierField
                    anchors.fill: parent
                    anchors.margins: 1
                    placeholderText: "+0"
                    validator: IntValidator { bottom: -99; top: 99 }
                    text: "0"
                    selectByMouse: true

                    style: TextFieldStyle {
                        background: Rectangle {
                            radius: 7
                            color: "transparent"
                        }
                        textColor: textPrimary
                        placeholderTextColor: textSecondary
                    }
                }
            }
        }
    }


    SequentialAnimation {
        id: rollAnimation

        NumberAnimation {
            target: resultText
            property: "scale"
            to: 1.2
            duration: 200
        }
        NumberAnimation {
            target: resultText
            property: "scale"
            to: 1.0
            duration: 200
        }
    }

    function rollDice(diceType, maxValue) {
        var baseRoll = Math.floor(Math.random() * maxValue) + 1
        var modifier = parseInt(modifierField.text) || 0
        var total = baseRoll + modifier

        lastRoll = total
        lastDice = diceType

        var modText = modifier !== 0 ? " (" + baseRoll + (modifier >= 0 ? "+" : "") + modifier + ")" : ""
        resultText.text = diceType + ": " + total + modText

        rollAnimation.start()


        if (diceType === "d20") {
            if (baseRoll === 20) {
                resultText.text += " 🔥 CRITICAL!"
                resultText.color = successColor
            } else if (baseRoll === 1) {
                resultText.text += " 💀 FUMBLE!"
                resultText.color = dangerColor
            } else {
                resultText.color = textPrimary
            }
        } else {
            resultText.color = textPrimary
        }
    }
}
