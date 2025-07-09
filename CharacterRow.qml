import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {
    id: root

    property int characterIndex: -1
    property color surfaceColor: "#1a1b26"
    property color cardColor: "#24283b"
    property color accentColor: "#7c3aed"
    property color successColor: "#10b981"
    property color dangerColor: "#ef4444"
    property color warningColor: "#f59e0b"
    property color textPrimary: "#c9d1d9"
    property color textSecondary: "#8b949e"
    property color borderColor: "#30363d"
    property color inactiveColor: "#6b7280"

    signal editRequested()
    signal notesRequested()
    signal deleteRequested()
    signal activateRequested()
    signal eliminateRequested()
    signal damageRequested(int damage)
    signal healingRequested(int healing)

    height: 55


    color: {
        if (model && model.isCurrentTurn) {
            return mouseArea.containsMouse ? Qt.lighter(accentColor, 1.1) : accentColor
        } else {
            return mouseArea.containsMouse ? Qt.lighter(cardColor, 1.2) : cardColor
        }
    }

    radius: 12
    border.width: model && model.isCurrentTurn ? 2 : 1
    border.color: {
        if (model && model.isCurrentTurn) {
            return "#ffffff"
        } else if (model && model.isEnemy) {
            return dangerColor
        } else {
            return borderColor
        }
    }

    opacity: (model && model.isActive) ? 1.0 : 0.7


    Rectangle {
        anchors.fill: parent
        anchors.margins: -1
        radius: parent.radius + 1
        color: "transparent"
        border.width: 1
        border.color: model && model.isCurrentTurn ? Qt.rgba(1, 1, 1, 0.2) : Qt.rgba(0, 0, 0, 0.1)
        z: -1
        visible: model && model.isCurrentTurn
    }


    SequentialAnimation {
        id: currentTurnAnimation
        running: model && model.isCurrentTurn
        loops: Animation.Infinite

        NumberAnimation {
            target: root
            property: "border.width"
            to: 3
            duration: 1200
        }
        NumberAnimation {
            target: root
            property: "border.width"
            to: 2
            duration: 1200
        }
    }

    Behavior on color {
        ColorAnimation { duration: 250 }
    }

    Behavior on opacity {
        NumberAnimation { duration: 200 }
    }

    Behavior on border.color {
        ColorAnimation { duration: 250 }
    }


    Rectangle {
        visible: model && model.isCurrentTurn
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 2
        width: 6
        color: "#ffffff"
        radius: 3

        SequentialAnimation {
            running: parent.visible
            loops: Animation.Infinite

            NumberAnimation {
                target: parent
                property: "opacity"
                to: 0.4
                duration: 1000
            }
            NumberAnimation {
                target: parent
                property: "opacity"
                to: 1.0
                duration: 1000
            }
        }
    }

    Row {
        anchors.fill: parent
        anchors.margins: 12
        anchors.leftMargin: (model && model.isCurrentTurn) ? 18 : 12
        spacing: 5


        Text {
            width: 135
            text: model ? (model.name || "") : ""
            color: {
                if (model && model.isCurrentTurn) {
                    return "white"
                } else if (model && !model.isActive) {
                    return inactiveColor
                } else {
                    return textPrimary
                }
            }
            font.bold: model && model.isCurrentTurn
            font.pixelSize: model && model.isCurrentTurn ? 15 : 14
            font.weight: model && model.isCurrentTurn ? Font.Bold : Font.Medium
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }


        Rectangle {
            width: 50
            height: 30
            radius: 8
            color: model && model.isCurrentTurn ? "rgba(255,255,255,0.15)" : "rgba(255,255,255,0.05)"
            border.width: 1
            border.color: model && model.isCurrentTurn ? "rgba(255,255,255,0.3)" : borderColor
            anchors.verticalCenter: parent.verticalCenter

            Text {
                anchors.centerIn: parent
                text: model ? (model.level || 0).toString() : "0"
                color: model && model.isCurrentTurn ? "white" : (model && model.isActive ? textPrimary : inactiveColor)
                font.pixelSize: 13
                font.weight: Font.Medium
            }
        }


        Rectangle {
            width: 60
            height: 32
            radius: 8
            color: {
                if (model && model.health <= 0) return dangerColor
                if (model && model.isCurrentTurn) return "rgba(255,255,255,0.15)"
                return successColor
            }
            opacity: model && model.health <= 0 ? 1.0 : 0.8
            border.width: 1
            border.color: model && model.health <= 0 ? Qt.lighter(dangerColor, 1.2) : (model && model.isCurrentTurn ? "rgba(255,255,255,0.3)" : Qt.lighter(successColor, 1.2))
            anchors.verticalCenter: parent.verticalCenter

            Text {
                anchors.centerIn: parent
                text: model ? (model.health || 0).toString() : "0"
                color: {
                    if (model && model.health <= 0) return "white"
                    if (model && model.isCurrentTurn) return "white"
                    return "white"
                }
                font.pixelSize: 13
                font.weight: Font.Bold
            }
        }


        Rectangle {
            width: 50
            height: 30
            radius: 8
            color: model && model.isCurrentTurn ? "rgba(255,255,255,0.15)" : warningColor
            opacity: 0.8
            border.width: 1
            border.color: model && model.isCurrentTurn ? "rgba(255,255,255,0.3)" : Qt.lighter(warningColor, 1.2)
            anchors.verticalCenter: parent.verticalCenter

            Text {
                anchors.centerIn: parent
                text: model ? (model.armor || 0).toString() : "0"
                color: "white"
                font.pixelSize: 13
                font.weight: Font.Bold
            }
        }


        Rectangle {
            width: 60
            height: 35
            color: model && model.isCurrentTurn ? "#ffffff" : accentColor
            radius: 10
            opacity: (model && model.isActive) ? 1.0 : 0.6
            anchors.verticalCenter: parent.verticalCenter

            gradient: Gradient {
                GradientStop { position: 0.0; color: model && model.isCurrentTurn ? "#ffffff" : accentColor }
                GradientStop { position: 1.0; color: model && model.isCurrentTurn ? "#f8f8ff" : Qt.darker(accentColor, 1.1) }
            }

            Text {
                anchors.centerIn: parent
                text: model ? (model.initiative || 0).toString() : "0"
                color: model && model.isCurrentTurn ? accentColor : "white"
                font.bold: true
                font.pixelSize: 15
                font.weight: Font.Bold
            }
        }


        Rectangle {
            width: 80
            height: 24
            color: (model && model.statusText === "Active") ? successColor : dangerColor
            radius: 12
            opacity: (model && model.isActive) ? 0.9 : 0.5
            anchors.verticalCenter: parent.verticalCenter

            Text {
                anchors.centerIn: parent
                text: model ? (model.statusText || "Inactive") : "Inactive"
                color: "white"
                font.pixelSize: 10
                font.weight: Font.Bold
            }
        }


        Rectangle {
            width: 70
            height: 24
            color: (model && model.isEnemy) ? dangerColor : successColor
            radius: 12
            opacity: (model && model.isActive) ? 0.9 : 0.5
            anchors.verticalCenter: parent.verticalCenter

            Text {
                anchors.centerIn: parent
                text: model ? (model.typeText || "Friend") : "Friend"
                color: "white"
                font.pixelSize: 10
                font.weight: Font.Bold
            }
        }


        Rectangle {
            width: Math.max(100, parent.width - 520)
            height: 30
            radius: 6
            color: model && model.isCurrentTurn ? "rgba(255,255,255,0.1)" : "rgba(255,255,255,0.03)"
            border.width: 1
            border.color: model && model.isCurrentTurn ? "rgba(255,255,255,0.2)" : borderColor
            anchors.verticalCenter: parent.verticalCenter

            Text {
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                text: model ? (model.statuses || "No effects") : "No effects"
                color: model && model.isCurrentTurn ? "white" : (model && model.isActive ? textPrimary : inactiveColor)
                font.pixelSize: 12
                font.weight: Font.Medium
                elide: Text.ElideRight
                width: parent.width - 16
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: {
            if (mouse.button === Qt.RightButton) {
                contextMenu.popup()
            }
        }
    }

    Menu {
        id: contextMenu

        MenuItem {
            text: "📝 Show Notes"
            onTriggered: root.notesRequested()
        }

        MenuSeparator {}


        MenuItem {
            text: "⚔️ 1 Damage"
            onTriggered: root.damageRequested(1)
        }

        MenuItem {
            text: "⚔️ 5 Damage"
            onTriggered: root.damageRequested(5)
        }

        MenuItem {
            text: "⚔️ 10 Damage"
            onTriggered: root.damageRequested(10)
        }

        MenuItem {
            text: "⚔️ 20 Damage"
            onTriggered: root.damageRequested(20)
        }

        MenuSeparator {}


        MenuItem {
            text: "❤️ 1 Healing"
            onTriggered: root.healingRequested(1)
        }

        MenuItem {
            text: "❤️ 5 Healing"
            onTriggered: root.healingRequested(5)
        }

        MenuItem {
            text: "❤️ 10 Healing"
            onTriggered: root.healingRequested(10)
        }

        MenuItem {
            text: "❤️ 20 Healing"
            onTriggered: root.healingRequested(20)
        }

        MenuSeparator {}

        MenuItem {
            text: (model && model.isActive) ? "💀 Eliminate" : "❤️ Reactivate"
            onTriggered: {
                if (model && model.isActive) {
                    root.eliminateRequested()
                } else {
                    root.activateRequested()
                }
            }
        }

        MenuItem {
            text: "✏️ Edit"
            onTriggered: root.editRequested()
        }

        MenuSeparator {}

        MenuItem {
            text: "🗑️ Delete"
            onTriggered: root.deleteRequested()
        }
    }
}
