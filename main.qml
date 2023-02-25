import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import Qt.labs.settings

ApplicationWindow {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Záskoq")

    property url lastFile
    property var lines: []
    property int currentLine: 0

    onLastFileChanged: openFile(lastFile)

    function openFile(file) {
        var rawFile = new XMLHttpRequest();
        rawFile.onreadystatechange = function() {
            if (rawFile.readyState === 4) {
                root.lines = JSON.parse(rawFile.responseText)
            }
        }
        rawFile.open("GET", lastFile, true);
        rawFile.send();
    }

    Settings {
        id: settings
        property alias lastFile: root.lastFile
        property alias currentLine: root.currentLine
    }

    FileDialog {
        id: openDialog
        fileMode: FileDialog.OpenFile
        onAccepted: {
            root.lastFile = selectedFile
        }
    }

    menuBar: MenuBar {
        Menu {
            title: "Menu"

            Action {
                text: "&Open..."
                icon.name: "document-open"
                shortcut: StandardKey.Open
                onTriggered: {
                    openDialog.open()
                }
            }
        }
    }

    footer: ProgressBar {
        from: 1
        to: root.lines.length > 0 ? root.lines.length : 0
        value: root.currentLine+1

        Label {
            anchors.centerIn: parent
            text: (root.lastFile != "") ? ((root.currentLine+1)+"/"+root.lines.length) : ""
            z: 10
        }
    }

    Label {
        focus: true
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        text: root.lines.length > 0 ? root.lines[root.currentLine] : ""

        Keys.onLeftPressed: {
            if (root.currentLine > 0) {
                root.currentLine--
            }
        }

        Keys.onRightPressed: {
            if (root.currentLine < root.lines.length-1) {
                root.currentLine++
            }
        }
    }
}
