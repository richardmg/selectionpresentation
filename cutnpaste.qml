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

            interactive: false

            model: RaceModel {}

            selectionModel: ItemSelectionModel {
                model: tableView.model
            }

            delegate: Rectangle {
                color: selected ? "lightblue" : "white"
                implicitWidth: 150
                implicitHeight: 30
                clip: true

                required property bool selected

                Text {
                    text: model.display
                }
            }
        }

        SelectionRectangle {
            target: tableView
            selectionMode: SelectionRectangle.Auto
            topLeftHandle: Handle {}
            bottomRightHandle: Handle {}

            component Handle : Rectangle {
                width: 10
                height: 10
                color: SelectionRectangle.dragging ? "red" : "blue"
                opacity: SelectionRectangle.control.active ? 1 : 0
                Behavior on opacity { NumberAnimation {} }
            }
        }

    }
}

/*
Script:

So, TableView in Qt Quick has been around for more than three years now. And there is still quite som
functionallity that we think is missing in it, for it to be a versatile and complete TableView control.

And one of those things is the possibilty to simply select cells inside the table. Either by doing a
PressAndHold, or by dragging. So we decided to implement this for Qt 6.2.

And this is now ready. And I'll quickly show how it works.

So the first you need to to is to create a SelectionRectangle. A SelectionRectangle will have
use the style to draw selection handles, and therefore belongs to Qt Quick Controls, rather than
Qt Quick, where TableView lives.

[create it]

It's also supposed to be quite generic so that it can be reused several places where we might need
selection support in the future. Today it only works with TableView, but at least implementing
support also for ListView in the future would be a natural thing to do.

In order for a SelectionRectangle to be able to select any cells, a TableView needs to offer a
selectionModel. Because TableView itself will not actually store any selections. Instead, that
part is outsourced to an ItemSelectionModel.

[create it]

And in order for TableView to actually show the selections set in the selection model, you need
to draw a delegate as selected. So finally you need create a special property in the delegate
called "required property bool selected". TableView will detect this property, and update it
according to the state of the model item inside the selection model.

It needs to be required. If you skip required, TableView will leave it alone. TableView has
been around for some years, so it can easily happen that there are delegates out there that
has such a property from before. And we don't want to break those applications.

Required means that the property needs to have a value assigned when
the delegate item is created. And the only one that instantiates delegate items is TableView,
so by making it required, you explixitly hand over responsibility for it to TableView.

[demo selection]
[show how to use Drag]
[explain PressAndHold, and show Auto with interactive]
[show how handles are hidden in macOS]
[implement custom handles]

*/
