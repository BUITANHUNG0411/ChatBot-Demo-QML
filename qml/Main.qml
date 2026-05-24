import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ChatBotDemo

Window {
    id: root
    width: 1200
    height: 800
    visible: true
    title: qsTr("Dashboard")

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            Layout.preferredWidth: 56
            Layout.fillHeight: true
            color: Theme_Color.surface

            ColumnLayout {
                anchors.fill: parent
                spacing: 8
                anchors.topMargin: 16

                ToolButton {
                    id: btnHome
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 44
                    hoverEnabled: true
                    ToolTip.text: "Home"
                    ToolTip.visible: hovered
                    ToolTip.delay: 300
                    onClicked: stackLayout.currentIndex = 0
                    contentItem: Image {
                        anchors.centerIn: parent
                        width: 22
                        height: 22
                        source: "../assets/home.svg"
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                    }
                }
                ToolButton {
                    id: btnChat
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 44
                    hoverEnabled: true
                    ToolTip.text: "Chat"
                    ToolTip.visible: hovered
                    ToolTip.delay: 300
                    onClicked: stackLayout.currentIndex = 1
                    contentItem: Image {
                        anchors.centerIn: parent
                        width: 22
                        height: 22
                        source: "../assets/chat.svg"
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                    }
                }
                ToolButton {
                    id: btnNote
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 44
                    hoverEnabled: true
                    ToolTip.text: "Note"
                    ToolTip.visible: hovered
                    ToolTip.delay: 300
                    onClicked: stackLayout.currentIndex = 2
                    contentItem: Image {
                        anchors.centerIn: parent
                        width: 22
                        height: 22
                        source: "../assets/note.svg"
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                    }
                }
                ToolButton {
                    id: btnWeather
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 44
                    hoverEnabled: true
                    ToolTip.text: "Weather"
                    ToolTip.visible: hovered
                    ToolTip.delay: 300
                    onClicked: stackLayout.currentIndex = 3
                    contentItem: Image {
                        anchors.centerIn: parent
                        width: 22
                        height: 22
                        source: "../assets/weather.svg"
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                    }
                }
                ToolButton {
                    id: btnMap
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 44
                    hoverEnabled: true
                    ToolTip.text: "Map"
                    ToolTip.visible: hovered
                    ToolTip.delay: 300
                    onClicked: stackLayout.currentIndex = 4
                    contentItem: Image {
                        anchors.centerIn: parent
                        width: 22
                        height: 22
                        source: "../assets/map.svg"
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                    }
                }
                ToolButton {
                    id: btnContact
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 44
                    hoverEnabled: true
                    ToolTip.text: "Contact"
                    ToolTip.visible: hovered
                    ToolTip.delay: 300
                    onClicked: stackLayout.currentIndex = 5
                    contentItem: Image {
                        anchors.centerIn: parent
                        width: 22
                        height: 22
                        source: "../assets/contact.svg"
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                    }
                }
                ToolButton {
                    id: btnMusic
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 44
                    hoverEnabled: true
                    ToolTip.text: "Music"
                    ToolTip.visible: hovered
                    ToolTip.delay: 300
                    onClicked: stackLayout.currentIndex = 6
                    contentItem: Image {
                        anchors.centerIn: parent
                        width: 22
                        height: 22
                        source: "../assets/music.svg"
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                    }
                }

                Item { Layout.fillHeight: true }

                Switch {
                    Layout.alignment: Qt.AlignHCenter
                    checked: chatBackend.isDarkMode
                    onToggled: chatBackend.isDarkMode = checked
                }

                Item { Layout.preferredHeight: 16 }
            }
        }

        StackLayout {
            id: stackLayout
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: 0

            Home {}
            Chatbot {}
            Note {}
            Weather {}
            Map {}
            Contact {}
            Music {}
        }
    }
}
