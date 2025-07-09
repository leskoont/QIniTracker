import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

Dialog {
    id: dialog
    modality: Qt.ApplicationModal
    width: 400
    height: 300

    property string confirmTitle: ""
    property string confirmMessage: ""
    property var confirmAction: null
    property color dangerColor: "#f44336"

    function show(title, message, action) {
        confirmTitle = title
        confirmMessage = message
        confirmAction = action
        dialog.title = title
        dialog.open()
    }

    contentItem: Column {
        spacing: 20
        anchors.fill: parent
        anchors.margins: 20


        Rectangle {
            width: 64
            height: 64
            radius: 32
            color: dangerColor
            opacity: 0.2
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                anchors.centerIn: parent
                text: "⚠️"
                font.pixelSize: 32
            }
        }


        ScrollView {
            width: parent.width
            height: parent.height - 150

            Text {
                width: parent.width
                text: confirmMessage
                color: "black"
                font.pixelSize: 14
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
            }
        }


        Rectangle {
            width: parent.width
            height: 40
            color: dangerColor
            opacity: 0.2
            radius: 8

            Text {
                anchors.fill: parent
                anchors.margins: 10
                text: "⚠️ This action cannot be undone!"
                color: dangerColor
                font.pixelSize: 12
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    standardButtons: StandardButton.Cancel | StandardButton.Ok

    onAccepted: {
        if (confirmAction) {
            confirmAction()
        }
        dialog.close()
    }

    onRejected: dialog.close()
}
