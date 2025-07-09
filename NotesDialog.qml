import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

Dialog {
    id: dialog
    title: "Character Notes"
    modality: Qt.ApplicationModal
    width: 500
    height: 400

    property int characterIndex: -1
    property string characterName: ""
    property color accentColor: "#8e24aa"

    function openForCharacter(index) {
        characterIndex = index
        var character = characterModel.getCharacter(index)
        if (character) {
            characterName = character.name
            notesArea.text = character.notes
            dialog.title = "Notes - " + characterName
        }
        dialog.open()
        notesArea.focus = true
    }

    function saveNotes() {
        if (characterIndex >= 0) {
            characterModel.setCharacterNotes(characterIndex, notesArea.text)
        }
        dialog.close()
    }

    contentItem: Column {
        spacing: 15
        anchors.fill: parent
        anchors.margins: 20


        Rectangle {
            width: parent.width
            height: 50
            color: "#8a7ca8"
            radius: 8

            Row {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 10

                Text {
                    text: "📝"
                    font.pixelSize: 20
                    color: "white"
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    text: "Notes for: " + characterName
                    font.pixelSize: 16
                    font.bold: true
                    color: "white"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }


        Item {
            width: parent.width
            height: parent.height - 120

            ScrollView {
                anchors.fill: parent

                TextArea {
                    id: notesArea
                    text: ""
                    wrapMode: TextArea.Wrap
                }
            }
        }


        Rectangle {
            width: parent.width
            height: 30
            color: "transparent"

            Row {
                anchors.fill: parent

                Text {
                    text: "Characters: " + (notesArea.text ? notesArea.text.length : 0)
                    color: "#888"
                    font.pixelSize: 12
                    anchors.verticalCenter: parent.verticalCenter
                }

                Item { width: parent.width - 150 }

                Text {
                    text: (notesArea.text && notesArea.text.trim() !== "") ? "Modified" : "No notes"
                    color: (notesArea.text && notesArea.text.trim() !== "") ? accentColor : "#888"
                    font.pixelSize: 12
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }

    standardButtons: StandardButton.Cancel | StandardButton.Save

    onAccepted: saveNotes()
    onRejected: dialog.close()
}
