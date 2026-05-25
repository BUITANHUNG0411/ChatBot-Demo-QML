import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import ChatBotDemo

Rectangle {
    id: clusterRoot
    color: Theme_Color.background

    property real motor1Velocity: 0
    property real motor2Velocity: 0

    RowLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        // Part 1: Motor Velocity Watches
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 16

            // Part 1.1: Title
            Label {
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                text: "GA37 Motor controlled by STM32F103C8T6"
                font.pixelSize: 24
                font.weight: Font.Bold
                font.family: "Segoe UI"
                color: Theme_Color.primaryText
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
            }

            // Part 1.2: Motor 1 Watch
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: Theme_Color.surface
                radius: 16
                border.color: Theme_Color.borderColor
                border.width: 1

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 16

                    Label {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                        text: "Velocity of Motor 1"
                        font.pixelSize: 18
                        font.weight: Font.Medium
                        font.family: "Segoe UI"
                        color: Theme_Color.primaryText
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                    }

                    Item {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Watch {
                            anchors.centerIn: parent
                            width: Math.min(parent.width, parent.height) * 0.85
                            height: width
                            value: clusterRoot.motor1Velocity
                            maxValue: 100
                        }
                    }
                }
            }

            // Part 1.3: Motor 2 Watch
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: Theme_Color.surface
                radius: 16
                border.color: Theme_Color.borderColor
                border.width: 1

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 16

                    Label {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                        text: "Velocity of Motor 2"
                        font.pixelSize: 18
                        font.weight: Font.Medium
                        font.family: "Segoe UI"
                        color: Theme_Color.primaryText
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                    }

                    Item {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Watch {
                            anchors.centerIn: parent
                            width: Math.min(parent.width, parent.height) * 0.85
                            height: width
                            value: clusterRoot.motor2Velocity
                            maxValue: 100
                        }
                    }
                }
            }
        }

        // Part 2: PWM Control
        PWM_Control {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
