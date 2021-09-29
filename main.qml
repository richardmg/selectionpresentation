import QtQuick
import QtQuick.Controls
import QtQuick.Window

import QtQml.Models

ApplicationWindow {
    id: window
    width: 600
    height: 400
    visible: true

    Column {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        TableView {
            id: tableView
            width: parent.width
            height: parent.height - 100
            columnSpacing: 1
            rowSpacing: 1
            clip: true
            ScrollBar.horizontal: ScrollBar { policy: ScrollBar.AlwaysOn }
            ScrollBar.vertical: ScrollBar { policy: ScrollBar.AlwaysOn }

            model: RaceModel {}

            delegate: Rectangle {
                color: "white"
                implicitWidth: 150
                implicitHeight: 30
                clip: true

                Text {
                    text: model.display
                }
            }
        }

    }
}
