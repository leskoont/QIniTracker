import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle {
    id: root
    height: 200
    color: "#24283b"
    radius: 16
    border.width: 1
    border.color: "#30363d"

    property color accentColor: "#7c3aed"
    property color dangerColor: "#ef4444"
    property color successColor: "#10b981"
    property color textPrimary: "#c9d1d9"
    property color textSecondary: "#8b949e"
    property color surfaceColor: "#1a1b26"


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
                text: "⚔️"
                font.pixelSize: 18
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                text: "Damage Calculator"
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


        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 12

            Rectangle {
                width: 100
                height: 35
                radius: 8
                color: surfaceColor
                border.width: 1
                border.color: "#30363d"

                TextField {
                    id: damageField
                    anchors.fill: parent
                    anchors.margins: 1
                    placeholderText: "Amount"
                    validator: IntValidator { bottom: 0; top: 9999 }
                    text: "1"
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

            Text {
                text: "points"
                color: textSecondary
                font.pixelSize: 14
                font.weight: Font.Medium
                anchors.verticalCenter: parent.verticalCenter
            }
        }


        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 12

            ModernButton {
                text: "Deal Damage"
                iconText: "⚔️"
                buttonColor: dangerColor
                width: 110
                height: 40
                onClicked: {
                    var damage = parseInt(damageField.text) || 0
                    if (damage > 0) {
                        damageApplied(damage, false)
                    }
                }
            }

            ModernButton {
                text: "Heal"
                iconText: "❤️"
                buttonColor: successColor
                width: 90
                height: 40
                onClicked: {
                    var healing = parseInt(damageField.text) || 0
                    if (healing > 0) {
                        damageApplied(healing, true)
                    }
                }
            }
        }


        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 8

            Rectangle {
                width: 40
                height: 28
                radius: 8
                color: mouseArea1.containsMouse ? Qt.lighter(surfaceColor, 1.3) : surfaceColor
                border.width: 1
                border.color: mouseArea1.containsMouse ? accentColor : "#30363d"

                Text {
                    anchors.centerIn: parent
                    text: "1"
                    color: mouseArea1.containsMouse ? textPrimary : textSecondary
                    font.pixelSize: 12
                    font.weight: Font.Bold
                }

                MouseArea {
                    id: mouseArea1
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: damageField.text = "1"
                }

                Behavior on color {
                    ColorAnimation { duration: 150 }
                }

                Behavior on border.color {
                    ColorAnimation { duration: 150 }
                }
            }

            Rectangle {
                width: 40
                height: 28
                radius: 8
                color: mouseArea5.containsMouse ? Qt.lighter(surfaceColor, 1.3) : surfaceColor
                border.width: 1
                border.color: mouseArea5.containsMouse ? accentColor : "#30363d"

                Text {
                    anchors.centerIn: parent
                    text: "5"
                    color: mouseArea5.containsMouse ? textPrimary : textSecondary
                    font.pixelSize: 12
                    font.weight: Font.Bold
                }

                MouseArea {
                    id: mouseArea5
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: damageField.text = "5"
                }

                Behavior on color {
                    ColorAnimation { duration: 150 }
                }

                Behavior on border.color {
                    ColorAnimation { duration: 150 }
                }
            }

            Rectangle {
                width: 40
                height: 28
                radius: 8
                color: mouseArea10.containsMouse ? Qt.lighter(surfaceColor, 1.3) : surfaceColor
                border.width: 1
                border.color: mouseArea10.containsMouse ? accentColor : "#30363d"

                Text {
                    anchors.centerIn: parent
                    text: "10"
                    color: mouseArea10.containsMouse ? textPrimary : textSecondary
                    font.pixelSize: 12
                    font.weight: Font.Bold
                }

                MouseArea {
                    id: mouseArea10
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: damageField.text = "10"
                }

                Behavior on color {
                    ColorAnimation { duration: 150 }
                }

                Behavior on border.color {
                    ColorAnimation { duration: 150 }
                }
            }

            Rectangle {
                width: 40
                height: 28
                radius: 8
                color: mouseArea20.containsMouse ? Qt.lighter(surfaceColor, 1.3) : surfaceColor
                border.width: 1
                border.color: mouseArea20.containsMouse ? accentColor : "#30363d"

                Text {
                    anchors.centerIn: parent
                    text: "20"
                    color: mouseArea20.containsMouse ? textPrimary : textSecondary
                    font.pixelSize: 12
                    font.weight: Font.Bold
                }

                MouseArea {
                    id: mouseArea20
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: damageField.text = "20"
                }

                Behavior on color {
                    ColorAnimation { duration: 150 }
                }

                Behavior on border.color {
                    ColorAnimation { duration: 150 }
                }
            }
        }
    }

    signal damageApplied(int amount, bool isHealing)
}
