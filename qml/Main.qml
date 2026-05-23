import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

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
            color: chatBackend.isDarkMode ? "#1e293b" : "#f1f5f9"

            ColumnLayout {
                anchors.fill: parent
                spacing: 8
                anchors.topMargin: 16

                ToolButton {
                    id: btnChat
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 44
                    tooltip: "Chat"
                    hoverEnabled: true
                    ToolTip.text: "Chat"
                    ToolTip.visible: hovered
                    ToolTip.delay: 300
                    onClicked: stackLayout.currentIndex = 1
                    contentItem: Image {
                        anchors.centerIn: parent
                        width: 22
                        height: 22
                        source: "qrc:/ChatBotDemo/assets/chat.svg"
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                    }
                }
                ToolButton {
                    id: btnNote
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 44
                    tooltip: "Note"
                    hoverEnabled: true
                    ToolTip.text: "Note"
                    ToolTip.visible: hovered
                    ToolTip.delay: 300
                    onClicked: stackLayout.currentIndex = 2
                    contentItem: Image {
                        anchors.centerIn: parent
                        width: 22
                        height: 22
                        source: "qrc:/ChatBotDemo/assets/note.svg"
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                    }
                }
                ToolButton {
                    id: btnWeather
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 44
                    tooltip: "Weather"
                    hoverEnabled: true
                    ToolTip.text: "Weather"
                    ToolTip.visible: hovered
                    ToolTip.delay: 300
                    onClicked: stackLayout.currentIndex = 3
                    contentItem: Image {
                        anchors.centerIn: parent
                        width: 22
                        height: 22
                        source: "qrc:/ChatBotDemo/assets/weather.svg"
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                    }
                }
                ToolButton {
                    id: btnMap
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 44
                    tooltip: "Map"
                    hoverEnabled: true
                    ToolTip.text: "Map"
                    ToolTip.visible: hovered
                    ToolTip.delay: 300
                    onClicked: stackLayout.currentIndex = 4
                    contentItem: Image {
                        anchors.centerIn: parent
                        width: 22
                        height: 22
                        source: "qrc:/ChatBotDemo/assets/map.svg"
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                    }
                }
                ToolButton {
                    id: btnContact
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 44
                    tooltip: "Contact"
                    hoverEnabled: true
                    ToolTip.text: "Contact"
                    ToolTip.visible: hovered
                    ToolTip.delay: 300
                    onClicked: stackLayout.currentIndex = 5
                    contentItem: Image {
                        anchors.centerIn: parent
                        width: 22
                        height: 22
                        source: "qrc:/ChatBotDemo/assets/contact.svg"
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                    }
                }
                ToolButton {
                    id: btnMusic
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 44
                    tooltip: "Music"
                    hoverEnabled: true
                    ToolTip.text: "Music"
                    ToolTip.visible: hovered
                    ToolTip.delay: 300
                    onClicked: stackLayout.currentIndex = 6
                    contentItem: Image {
                        anchors.centerIn: parent
                        width: 22
                        height: 22
                        source: "qrc:/ChatBotDemo/assets/music.svg"
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
