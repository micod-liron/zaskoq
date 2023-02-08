import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    menuBar: MenuBar {
        Menu {
            title: "Menu"

            Action {
                text: "&Open..."
                icon.name: "document-open"
                shortcut: StandardKey.Open
                onTriggered: {
                    console.log("open")
                }
            }
        }
    }
}
