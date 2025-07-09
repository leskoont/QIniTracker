import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import QIniTracker 1.0

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 1400
    height: 900
    minimumWidth: 1200
    minimumHeight: 700
    title: "QIniTracker v2.0 - D&D Initiative Tracker"


    property color backgroundColor: "#0f0f1a"
    property color surfaceColor: "#1a1b26"
    property color cardColor: "#24283b"
    property color accentColor: "#7c3aed"
    property color accentSecondary: "#a855f7"
    property color successColor: "#10b981"
    property color dangerColor: "#ef4444"
    property color warningColor: "#f59e0b"
    property color textPrimary: "#c9d1d9"
    property color textSecondary: "#8b949e"
    property color borderColor: "#30363d"


    Rectangle {
        anchors.fill: parent

        gradient: Gradient {
            GradientStop { position: 0.0; color: backgroundColor }
            GradientStop { position: 1.0; color: Qt.darker(backgroundColor, 1.2) }
        }
    }


    toolBar: Rectangle {
        height: 70
        color: surfaceColor


        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: 1
            color: borderColor
        }

        RowLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 20


            Row {
                spacing: 15

                Rectangle {
                    width: 50
                    height: 50
                    radius: 12
                    color: accentColor

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: accentColor }
                        GradientStop { position: 1.0; color: accentSecondary }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "⚔️"
                        font.pixelSize: 24
                        color: "white"
                    }
                }

                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 2

                    Text {
                        text: "QIniTracker"
                        font.pixelSize: 24
                        font.bold: true
                        color: textPrimary
                    }

                    Text {
                        text: "D&D Initiative Tracker v2.0"
                        font.pixelSize: 12
                        color: textSecondary
                    }
                }
            }

            Item { Layout.fillWidth: true }


            Row {
                spacing: 15


                Rectangle {
                    width: 240
                    height: 50
                    radius: 12
                    color: cardColor
                    border.width: 1
                    border.color: borderColor

                    Row {
                        anchors.fill: parent
                        anchors.margins: 15
                        spacing: 10

                        Rectangle {
                            width: 4
                            height: parent.height
                            radius: 2
                            color: accentColor
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 2

                            Text {
                                text: "Current Turn"
                                font.pixelSize: 11
                                color: textSecondary
                                font.weight: Font.Medium
                            }

                            Text {
                                text: characterModel.getCurrentCharacterName()
                                font.pixelSize: 14
                                font.bold: true
                                color: textPrimary
                            }
                        }
                    }
                }


                Rectangle {
                    width: 100
                    height: 50
                    radius: 12
                    color: cardColor
                    border.width: 1
                    border.color: borderColor

                    Column {
                        anchors.centerIn: parent
                        spacing: 2

                        Text {
                            text: "Round"
                            font.pixelSize: 11
                            color: textSecondary
                            font.weight: Font.Medium
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: characterModel.roundNumber.toString()
                            font.pixelSize: 16
                            font.bold: true
                            color: warningColor
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }


                Rectangle {
                    width: 120
                    height: 50
                    radius: 12
                    color: cardColor
                    border.width: 1
                    border.color: borderColor

                    Column {
                        anchors.centerIn: parent
                        spacing: 2

                        Text {
                            text: "Characters"
                            font.pixelSize: 11
                            color: textSecondary
                            font.weight: Font.Medium
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: characterModel.characterCount().toString()
                            font.pixelSize: 16
                            font.bold: true
                            color: successColor
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 24


        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: surfaceColor
            radius: 16
            border.width: 1
            border.color: borderColor


            Rectangle {
                anchors.fill: parent
                anchors.margins: -2
                radius: parent.radius + 2
                color: "transparent"
                border.width: 1
                border.color: Qt.rgba(0, 0, 0, 0.1)
                z: -1
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 24
                spacing: 20


                Rectangle {
                    Layout.fillWidth: true
                    height: 60
                    color: cardColor
                    radius: 12
                    border.width: 1
                    border.color: borderColor

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 15

                        Column {
                            spacing: 2

                            Text {
                                text: "Initiative Order"
                                font.pixelSize: 20
                                font.bold: true
                                color: textPrimary
                            }

                            Text {
                                text: "Manage combat turns and character order"
                                font.pixelSize: 12
                                color: textSecondary
                            }
                        }

                        Item { Layout.fillWidth: true }


                        Row {
                            spacing: 10

                            ModernButton {
                                text: "Previous"
                                iconText: "⬅️"
                                buttonColor: textSecondary
                                width: 100
                                height: 40
                                enabled: characterModel.characterCount() > 0
                                onClicked: characterModel.previousTurn()
                            }

                            ModernButton {
                                text: "Next Turn"
                                iconText: "➡️"
                                buttonColor: accentColor
                                width: 110
                                height: 40
                                enabled: characterModel.characterCount() > 0
                                onClicked: characterModel.nextTurn()
                            }

                            ModernButton {
                                text: "Reset"
                                iconText: "🔄"
                                buttonColor: dangerColor
                                width: 80
                                height: 40
                                enabled: characterModel.characterCount() > 0
                                onClicked: characterModel.resetTurn()
                            }
                        }
                    }
                }

                CharacterListView {
                    id: characterListView
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    model: characterModel
                }
            }
        }


        Rectangle {
            Layout.preferredWidth: 320
            Layout.fillHeight: true
            color: surfaceColor
            radius: 16
            border.width: 1
            border.color: borderColor


            Rectangle {
                anchors.fill: parent
                anchors.margins: -2
                radius: parent.radius + 2
                color: "transparent"
                border.width: 1
                border.color: Qt.rgba(0, 0, 0, 0.1)
                z: -1
            }

            ScrollView {
                anchors.fill: parent
                anchors.margins: 2

                Column {
                    width: parent.width - 4
                    spacing: 20
                    anchors.margins: 20


                    Rectangle {
                        width: parent.width
                        height: 50
                        color: cardColor
                        radius: 12
                        border.width: 1
                        border.color: borderColor

                        Text {
                            anchors.centerIn: parent
                            text: "⚙️ Control Panel"
                            font.pixelSize: 16
                            font.bold: true
                            color: textPrimary
                        }
                    }


                    Column {
                        width: parent.width
                        spacing: 12

                        Row {
                            spacing: 0

                            Item {
                                width: 4
                                height: 1
                            }

                            Text {
                                text: "Character Actions"
                                font.pixelSize: 14
                                font.bold: true
                                color: textPrimary
                            }
                        }

                        ModernButton {
                            width: parent.width
                            text: "Add Character"
                            iconText: "➕"
                            buttonColor: successColor
                            onClicked: characterEditDialog.openForNew()
                        }

                        ModernButton {
                            width: parent.width
                            text: "Delete All Enemies"
                            iconText: "🗡️"
                            buttonColor: dangerColor
                            enabled: characterModel.characterCount() > 0
                            onClicked: confirmDialog.show(
                                "Delete All Enemies",
                                "Are you sure you want to delete all enemy characters?",
                                function() { characterModel.removeAllEnemies(); }
                            )
                        }

                        ModernButton {
                            width: parent.width
                            text: "Clear All"
                            iconText: "🗑️"
                            buttonColor: Qt.darker(dangerColor, 1.2)
                            enabled: characterModel.characterCount() > 0
                            onClicked: confirmDialog.show(
                                "Clear All Characters",
                                "Are you sure you want to delete all characters?",
                                function() { characterModel.clearAll(); }
                            )
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: 1
                        color: borderColor
                    }


                    Column {
                        width: parent.width
                        spacing: 12

                        Row {
                            spacing: 0

                            Item {
                                width: 4
                                height: 1
                            }

                            Text {
                                text: "File Operations"
                                font.pixelSize: 14
                                font.bold: true
                                color: textPrimary
                            }
                        }

                        ModernButton {
                            width: parent.width
                            text: "Save Group"
                            iconText: "💾"
                            buttonColor: successColor
                            enabled: characterModel.characterCount() > 0
                            onClicked: saveFileDialog.open()
                        }

                        ModernButton {
                            width: parent.width
                            text: "Load Group"
                            iconText: "📁"
                            buttonColor: accentColor
                            onClicked: loadFileDialog.open()
                        }

                        ModernButton {
                            width: parent.width
                            text: "Add Group"
                            iconText: "➕"
                            buttonColor: warningColor
                            onClicked: addFileDialog.open()
                        }

                        ModernButton {
                            width: parent.width
                            text: "Sort by Initiative"
                            iconText: "⚡"
                            buttonColor: accentSecondary
                            enabled: characterModel.characterCount() > 1
                            onClicked: characterModel.sortByInitiative()
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: 1
                        color: borderColor
                    }


                    DamageCalculator {
                        width: parent.width

                        onDamageApplied: {
                            if (characterModel.currentTurnIndex >= 0) {
                                if (isHealing) {
                                    characterModel.applyHealing(characterModel.currentTurnIndex, amount)
                                } else {
                                    characterModel.applyDamage(characterModel.currentTurnIndex, amount)
                                }
                            }
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: 1
                        color: borderColor
                    }


                    DiceRoller {
                        width: parent.width
                    }


                    Item {
                        width: parent.width
                        height: 20
                    }
                }
            }
        }
    }


    CharacterEditDialog {
        id: characterEditDialog
    }

    NotesDialog {
        id: notesDialog
    }

    ConfirmDialog {
        id: confirmDialog
    }


    FileDialog {
        id: saveFileDialog
        title: "Save Character Group"
        nameFilters: ["Battle Tracker files (*.btl)", "All files (*)"]
        selectExisting: false

        onAccepted: {
            var path = fileUrl.toString()
            if (path.indexOf("file://") === 0) {
                path = path.substring(7)
            }
            if (path && !path.endsWith(".btl")) {
                path += ".btl"
            }
            if (path) {
                characterModel.saveToFile(path)
            }
        }
    }

    FileDialog {
        id: loadFileDialog
        title: "Load Character Group"
        nameFilters: ["Battle Tracker files (*.btl)", "All files (*)"]
        selectExisting: true

        onAccepted: {
            var path = fileUrl.toString()
            if (path.indexOf("file://") === 0) {
                path = path.substring(7)
            }
            if (path) {
                characterModel.loadFromFile(path)
            }
        }
    }

    FileDialog {
        id: addFileDialog
        title: "Add Character Group"
        nameFilters: ["Battle Tracker files (*.btl)", "All files (*)"]
        selectExisting: true

        onAccepted: {
            var path = fileUrl.toString()
            if (path.indexOf("file://") === 0) {
                path = path.substring(7)
            }
            if (path) {
                characterModel.addFromFile(path)
            }
        }
    }


    Connections {
        target: characterModel
        onCharacterAdded: characterModel.autoSave()
        onCharacterRemoved: characterModel.autoSave()
        onCharacterUpdated: characterModel.autoSave()
        onModelCleared: characterModel.autoSave()
        onCurrentTurnIndexChanged: characterModel.autoSave()
        onRoundNumberChanged: characterModel.autoSave()
    }

    Component.onCompleted: {
        characterModel.autoLoad()
    }
}
