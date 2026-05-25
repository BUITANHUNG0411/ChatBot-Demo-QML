import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ChatBotDemo

Rectangle {
    id: noteRoot
    color: Theme_Color.background

    Item{
        id : status
        property int todo : 0;
        property int done : 1;
        property int all  : 2;
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 40
        spacing: 25

        RowLayout {
            Layout.fillWidth: true
            spacing: 15

            Label {
                text: "My Notes"
                font.pixelSize: 32
                font.weight: Font.DemiBold
                color: Theme_Color.accent
                Layout.fillWidth: true
            }

            Button {
                id: addButton
                text: "＋ Add Note"
                flat: true
                font.weight: Font.Medium
                background: Rectangle {
                    implicitWidth: 150
                    implicitHeight: 32
                    radius: 16
                    color: Theme_Color.surface
                    border.color: Theme_Color.accent
                    border.width: 1
                }
                contentItem: Text {
                    text: addButton.text
                    font {
                        weight: addButton.font.weight
                        pixelSize: 14
                    }
                    color: Theme_Color.accent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    noteControl.addNote();
                    noteFilterControl.setCondition(status.todo);
                    noteFilterControl.invalidateFilter();
                }
            }

            Button {
                id: trashButton
                text: "Push all to trash"
                flat: true
                font.weight: Font.Medium
                background: Rectangle {
                    implicitWidth: 150
                    implicitHeight: 32
                    radius: 16
                    color: Theme_Color.surface
                    border.color: Theme_Color.accent
                    border.width: 1
                }
                contentItem: Row {
                    spacing: 6
                    anchors.centerIn: parent
                    Image {
                        source: "assets/rubbish.png"
                        width: 16
                        height: 16
                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        text: trashButton.text
                        font {
                            weight: trashButton.font.weight
                            pixelSize: 14
                        }
                        color: Theme_Color.accent
                        verticalAlignment: Text.AlignVCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                onClicked: {
                    noteControl.clearAllNote();
                    noteFilterControl.invalidateFilter();
                }
            }

            ComboBox {
                id: filterCombo
                model: ["To do", "Done", "All Notes"]
                implicitWidth: 150
                implicitHeight: 32
                font.weight: Font.Medium

                onActivated: {
                    noteFilterControl.setCondition(index);
                }

                background: Rectangle {
                    radius: 16
                    color: (filterCombo.pressed || filterCombo.hovered || filterCombo.down)
                        ? Theme_Color.surfaceElevated
                        : Theme_Color.surface
                    border.color: Theme_Color.accent
                    border.width: 1

                    Behavior on color {
                        ColorAnimation { duration: 200 }
                    }
                }

                contentItem: Text {
                    text: filterCombo.currentText
                    font {
                        weight: filterCombo.font.weight
                        pixelSize: 14
                    }
                    color: Theme_Color.accent
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 15
                    rightPadding: 30
                    elide: Text.ElideRight
                }

                indicator: Canvas {
                    x: filterCombo.width - 25
                    y: filterCombo.height / 2 - 3
                    width: 10
                    height: 5
                    onPaint: {
                        var context = getContext("2d");
                        context.reset();
                        context.moveTo(0, 0);
                        context.lineTo(width, 0);
                        context.lineTo(width / 2, height);
                        context.closePath();
                        context.fillStyle = Theme_Color.accent
                        context.fill();
                    }
                }

                delegate: ItemDelegate {
                    width: filterCombo.width
                    height: 32
                    contentItem: Text {
                        text: modelData
                        color: Theme_Color.accent
                        font {
                            weight: filterCombo.font.weight
                            pixelSize: 13
                        }
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 15
                    }
                    background: Rectangle {
                        color: (highlighted || index === filterCombo.currentIndex)
                            ? Theme_Color.surface
                            : Theme_Color.surfaceElevated
                        Behavior on color { ColorAnimation { duration: 150 } }
                    }
                }

                popup: Popup {
                    y: filterCombo.height + 5
                    width: filterCombo.width
                    implicitHeight: contentItem.implicitHeight
                    padding: 1

                    contentItem: ListView {
                        clip: true
                        implicitHeight: contentHeight
                        model: filterCombo.popup.visible ? filterCombo.delegateModel : null
                        ScrollIndicator.vertical: ScrollIndicator { }
                    }

                    background: Rectangle {
                        radius: 12
                        border.color: Theme_Color.accent
                        color: Theme_Color.surfaceElevated
                    }
                }
            }
        }

        ListView {
            id: notesListView
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: noteFilterControl
            spacing: 15
            clip: true

            delegate: Rectangle {
                width: notesListView.width
                height: 80
                radius: 12
                color: Theme_Color.surfaceElevated
                border.color: Theme_Color.borderColor
                border.width: 1

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 15

                    Rectangle {
                        Layout.preferredWidth: 4
                        Layout.fillHeight: true
                        radius: 2
                        color: model.status ? Theme_Color.borderColor : Theme_Color.accent

                        Behavior on color {
                            ColorAnimation {
                                duration: 200
                            }
                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 0
                        TextField {
                            id: noteInput
                            Layout.fillWidth: true
                            text: model.content
                            placeholderText: "Type note here..."
                            placeholderTextColor: Theme_Color.secondaryText
                            font.pixelSize: 16
                            color: model.status ? Theme_Color.secondaryText : Theme_Color.primaryText
                            font.strikeout: model.status
                            selectByMouse: true
                            background: null
                            onEditingFinished: noteControl.setContent(index, text)
                        }
                        Label {
                            text: model.timeStamp
                            font.pixelSize: 11
                            color: Theme_Color.secondaryText
                            Layout.leftMargin: 0
                        }
                    }

                    CheckBox {
                        id: doneCheck
                        checked: model.status
                        onClicked: {
                            noteControl.setStatus(index, checked);
                            noteFilterControl.invalidateFilter();
                        }

                        indicator: Rectangle {
                            implicitWidth: 24
                            implicitHeight: 24
                            radius: 6
                            color: "transparent"
                            border.color: doneCheck.checked
                                ? Theme_Color.accent
                                : Theme_Color.borderColor
                            border.width: 2

                            Text {
                                text: "✔"
                                font.pixelSize: 16
                                color: Theme_Color.accent
                                anchors.centerIn: parent
                                visible: doneCheck.checked
                            }
                        }
                    }

                    Button {
                        id: removeButton
                        text: "✕"
                        Layout.preferredWidth: 36
                        Layout.preferredHeight: 36
                        flat: true

                        background: Rectangle {
                            radius: 18
                            color: removeButton.hovered ? Theme_Color.dangerMuted : "transparent"
                        }

                        contentItem: Text {
                            text: removeButton.text
                            font.pixelSize: 18
                            color: removeButton.hovered ? Theme_Color.danger : Theme_Color.secondaryText
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        onClicked: noteControl.removeNote(index)
                    }
                }

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }

            add: Transition {
                NumberAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 400
                }
                NumberAnimation {
                    property: "scale"
                    from: 0.9
                    to: 1.0
                    duration: 400
                }
            }

            remove: Transition {
                NumberAnimation {
                    property: "opacity"
                    to: 0
                    duration: 200
                }
                NumberAnimation {
                    property: "scale"
                    to: 0.9
                    duration: 200
                }
            }

            displaced: Transition {
                NumberAnimation {
                    properties: "y"
                    duration: 400
                    easing.type: Easing.OutBounce
                }
            }
        }
    }
}
