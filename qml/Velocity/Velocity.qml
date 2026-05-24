import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import ChatBotDemo

Rectangle {
    id: velocityRoot
    color: Theme_Color.background

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 40
        spacing: 20

        // Part 1: Title
        Label {
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            text: "GA37 Motor controlled by STM32F103C8T6"
            font.pixelSize: 32
            font.weight: Font.Bold
            font.family: "Segoe UI"
            color: Theme_Color.primaryText
            horizontalAlignment: Label.AlignHCenter
            verticalAlignment: Label.AlignVCenter
        }

        // Part 2: Blank area
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Theme_Color.surface
            radius: 16
            border.color: Theme_Color.borderColor
            border.width: 1
        }

        // Part 3: Blank area
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Theme_Color.surface
            radius: 16
            border.color: Theme_Color.borderColor
            border.width: 1
        }
    }
}
