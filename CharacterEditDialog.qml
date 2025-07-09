import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

Dialog {
    id: dialog
    title: isEditMode ? "Edit Character" : "Add New Character"
    modality: Qt.ApplicationModal
    width: 500
    height: 600

    property bool isEditMode: false
    property int editIndex: -1

    property color accentColor: "#8e24aa"
    property color errorColor: "#f44336"

    function openForNew() {
        isEditMode = false
        editIndex = -1
        clearFields()
        dialog.open()
        nameField.focus = true
    }

    function openForEdit(index) {
        isEditMode = true
        editIndex = index
        loadCharacterData(index)
        dialog.open()
        nameField.focus = true
    }

    function clearFields() {
        nameField.text = ""
        levelField.text = "1"
        healthField.text = "10"
        armorField.text = "10"
        initiativeField.text = "0"
        isActiveCheckBox.checked = true
        isEnemyCheckBox.checked = false
        statusesField.text = ""
        notesField.text = ""
    }

    function loadCharacterData(index) {
        var character = characterModel.getCharacter(index)
        if (!character) return

        nameField.text = character.name
        levelField.text = character.level.toString()
        healthField.text = character.health.toString()
        armorField.text = character.armor.toString()
        initiativeField.text = character.initiative.toString()
        isActiveCheckBox.checked = character.isActive
        isEnemyCheckBox.checked = character.isEnemy
        statusesField.text = character.statuses
        notesField.text = character.notes
    }

    function validateAndSave() {

        var errors = []

        if (nameField.text.trim() === "") {
            errors.push("Name cannot be empty")
        }

        var level = parseInt(levelField.text)
        if (isNaN(level) || level < 0) {
            errors.push("Level must be a valid number >= 0")
        }

        var health = parseInt(healthField.text)
        if (isNaN(health)) {
            errors.push("Health must be a valid number")
        }

        var armor = parseInt(armorField.text)
        if (isNaN(armor) || armor < 0) {
            errors.push("Armor Class must be a valid number >= 0")
        }

        var initiative = parseInt(initiativeField.text)
        if (isNaN(initiative)) {
            errors.push("Initiative must be a valid number")
        }

        if (errors.length > 0) {
            errorText.text = "Errors:\n• " + errors.join("\n• ")
            errorText.visible = true
            return false
        }


        if (isEditMode) {
            characterModel.updateCharacter(
                editIndex,
                nameField.text.trim(),
                level,
                health,
                armor,
                initiative,
                isActiveCheckBox.checked,
                isEnemyCheckBox.checked,
                statusesField.text.trim(),
                notesField.text.trim()
            )
        } else {
            characterModel.addCharacter(
                nameField.text.trim(),
                level,
                health,
                armor,
                initiative,
                isActiveCheckBox.checked,
                isEnemyCheckBox.checked,
                statusesField.text.trim(),
                notesField.text.trim()
            )
        }

        dialog.close()
        return true
    }

    contentItem: Item {
        ScrollView {
            anchors.fill: parent
            anchors.margins: 20

            Column {
                width: dialog.width - 40
                spacing: 15


                Rectangle {
                    id: errorContainer
                    width: parent.width
                    height: errorText.visible ? errorText.contentHeight + 20 : 0
                    color: errorColor
                    radius: 8
                    opacity: 0.9
                    visible: errorText.visible

                    Behavior on height {
                        NumberAnimation { duration: 200 }
                    }

                    Text {
                        id: errorText
                        anchors.fill: parent
                        anchors.margins: 10
                        color: "white"
                        font.pixelSize: 12
                        wrapMode: Text.Wrap
                        visible: false
                    }
                }


                GroupBox {
                    width: parent.width
                    title: "Basic Information"

                    Grid {
                        width: parent.width
                        columns: 2
                        columnSpacing: 15
                        rowSpacing: 10

                        Label { text: "Name:" }
                        TextField {
                            id: nameField
                            width: 200
                            placeholderText: "Character name"
                            onTextChanged: errorText.visible = false
                        }

                        Label { text: "Level:" }
                        TextField {
                            id: levelField
                            width: 100
                            placeholderText: "1"
                            validator: IntValidator { bottom: 0; top: 99 }
                            onTextChanged: errorText.visible = false
                        }

                        Label { text: "Health (HP):" }
                        TextField {
                            id: healthField
                            width: 100
                            placeholderText: "10"
                            validator: IntValidator { bottom: -999; top: 9999 }
                            onTextChanged: errorText.visible = false
                        }

                        Label { text: "Armor Class:" }
                        TextField {
                            id: armorField
                            width: 100
                            placeholderText: "10"
                            validator: IntValidator { bottom: 0; top: 99 }
                            onTextChanged: errorText.visible = false
                        }

                        Label { text: "Initiative:" }
                        TextField {
                            id: initiativeField
                            width: 100
                            placeholderText: "0"
                            validator: IntValidator { bottom: -99; top: 99 }
                            onTextChanged: errorText.visible = false
                        }
                    }
                }


                GroupBox {
                    width: parent.width
                    title: "Status"

                    Column {
                        width: parent.width
                        spacing: 10

                        Row {
                            spacing: 20

                            CheckBox {
                                id: isActiveCheckBox
                                text: "Active"
                            }

                            CheckBox {
                                id: isEnemyCheckBox
                                text: "Enemy"
                            }
                        }
                    }
                }


                GroupBox {
                    width: parent.width
                    title: "Additional Information"

                    Column {
                        width: parent.width
                        spacing: 10

                        Label { text: "Status Effects:" }
                        TextField {
                            id: statusesField
                            width: parent.width
                            placeholderText: "e.g., Poisoned, Stunned, etc."
                        }

                        Label { text: "Notes:" }
                        Item {
                            width: parent.width
                            height: 80

                            TextArea {
                                id: notesField
                                anchors.fill: parent
                                text: ""
                                wrapMode: TextArea.Wrap
                            }
                        }
                    }
                }
            }
        }
    }

    standardButtons: StandardButton.Cancel | StandardButton.Ok

    onAccepted: validateAndSave()
    onRejected: dialog.close()
}
