import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Item {
    id: root

    property alias model: listView.model
    property color surfaceColor: "#1a1b26"
    property color cardColor: "#24283b"
    property color headerColor: "#7c3aed"
    property color textPrimary: "#c9d1d9"
    property color textSecondary: "#8b949e"
    property color borderColor: "#30363d"

    Column {
        anchors.fill: parent
        spacing: 0


        Rectangle {
            width: parent.width
            height: 50
            color: headerColor
            radius: 12

            gradient: Gradient {
                GradientStop { position: 0.0; color: headerColor }
                GradientStop { position: 1.0; color: Qt.lighter(headerColor, 1.1) }
            }

            Rectangle {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.radius
                color: headerColor
            }

            Row {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 5

                Text {
                    text: "Character Name";
                    width: 135;
                    color: "white";
                    font.bold: true;
                    font.pixelSize: 13;
                    font.weight: Font.Medium;
                    verticalAlignment: Text.AlignVCenter
                }
                Text {
                    text: "Lvl";
                    width: 50;
                    color: "white";
                    font.bold: true;
                    font.pixelSize: 13;
                    font.weight: Font.Medium;
                    verticalAlignment: Text.AlignVCenter
                }
                Text {
                    text: "Health";
                    width: 60;
                    color: "white";
                    font.bold: true;
                    font.pixelSize: 13;
                    font.weight: Font.Medium;
                    verticalAlignment: Text.AlignVCenter
                }
                Text {
                    text: "AC";
                    width: 50;
                    color: "white";
                    font.bold: true;
                    font.pixelSize: 13;
                    font.weight: Font.Medium;
                    verticalAlignment: Text.AlignVCenter
                }
                Text {
                    text: "Initiative";
                    width: 60;
                    color: "white";
                    font.bold: true;
                    font.pixelSize: 13;
                    font.weight: Font.Medium;
                    verticalAlignment: Text.AlignVCenter
                }
                Text {
                    text: "Status";
                    width: 80;
                    color: "white";
                    font.bold: true;
                    font.pixelSize: 13;
                    font.weight: Font.Medium;
                    verticalAlignment: Text.AlignVCenter
                }
                Text {
                    text: "Type";
                    width: 70;
                    color: "white";
                    font.bold: true;
                    font.pixelSize: 13;
                    font.weight: Font.Medium;
                    verticalAlignment: Text.AlignVCenter
                }
                Text {
                    text: "Effects & Notes";
                    width: Math.max(100, parent.width - 520);
                    color: "white";
                    font.bold: true;
                    font.pixelSize: 13;
                    font.weight: Font.Medium;
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }


        ScrollView {
            width: parent.width
            height: parent.height - 50

            style: ScrollViewStyle {
                transientScrollBars: false
                handle: Rectangle {
                    implicitWidth: 8
                    implicitHeight: 8
                    radius: 4
                    color: Qt.rgba(1, 1, 1, 0.3)
                }
                scrollBarBackground: Rectangle {
                    implicitWidth: 8
                    implicitHeight: 8
                    color: "transparent"
                }
            }

            ListView {
                id: listView
                anchors.fill: parent
                spacing: 3

                delegate: CharacterRow {
                    width: listView.width
                    characterIndex: index

                    onEditRequested: {
                        characterEditDialog.openForEdit(index)
                    }

                    onNotesRequested: {
                        notesDialog.openForCharacter(index)
                    }

                    onDeleteRequested: {
                        confirmDialog.show(
                            "Delete Character",
                            "Are you sure you want to delete " + (model ? (model.name || "this character") : "this character") + "?",
                            function() { characterModel.removeCharacter(index); }
                        )
                    }

                    onActivateRequested: {
                        characterModel.setCharacterActive(index, true)
                    }

                    onEliminateRequested: {
                        characterModel.setCharacterActive(index, false)
                    }

                    onDamageRequested: {
                        characterModel.applyDamage(index, damage)
                    }

                    onHealingRequested: {
                        characterModel.applyHealing(index, healing)
                    }
                }


                Rectangle {
                    anchors.centerIn: parent
                    width: 350
                    height: 120
                    radius: 16
                    color: cardColor
                    border.width: 1
                    border.color: borderColor
                    visible: listView.count === 0

                    Column {
                        anchors.centerIn: parent
                        spacing: 12

                        Text {
                            text: "🎭"
                            font.pixelSize: 32
                            color: textSecondary
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: "No Characters Yet"
                            color: textPrimary
                            font.pixelSize: 18
                            font.bold: true
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: "Click 'Add Character' to start tracking initiative!"
                            color: textSecondary
                            font.pixelSize: 14
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }
        }
    }
}
