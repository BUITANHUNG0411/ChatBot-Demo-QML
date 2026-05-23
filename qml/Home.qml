import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: chatBackend.isDarkMode ? "#0f172a" : "#e2e8f0"

    GridView {
        anchors.fill: parent
        anchors.margins: 40
        anchors.leftMargin: 60
        cellWidth: 280
        cellHeight: 220

        model: ListModel {
            ListElement {
                title: "Chat"
                icon: "qrc:/ChatBotDemo/assets/chat.svg"
                index: 1
            }
            ListElement {
                title: "Note"
                icon: "qrc:/ChatBotDemo/assets/note.svg"
                index: 2
            }
            ListElement {
                title: "Weather"
                icon: "qrc:/ChatBotDemo/assets/weather.svg"
                index: 3
            }
            ListElement {
                title: "Map"
                icon: "qrc:/ChatBotDemo/assets/map.svg"
                index: 4
            }
            ListElement {
                title: "Contact"
                icon: "qrc:/ChatBotDemo/assets/contact.svg"
                index: 5
            }
            ListElement {
                title: "Music"
                icon: "qrc:/ChatBotDemo/assets/music.svg"
                index: 6
            }
        }

        delegate: Rectangle {
            width: 260
            height: 200
            radius: 24
            color: chatBackend.isDarkMode
                ? Qt.rgba(30, 41, 59, 0.7)
                : Qt.rgba(255, 255, 255, 0.55)
            border.width: 1
            border.color: chatBackend.isDarkMode
                ? Qt.rgba(255, 255, 255, 0.08)
                : Qt.rgba(255, 255, 255, 0.8)
            clip: true

            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height / 2
                radius: 24
                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: chatBackend.isDarkMode
                            ? Qt.rgba(255, 255, 255, 0.05)
                            : Qt.rgba(255, 255, 255, 0.4)
                    }
                    GradientStop {
                        position: 1.0
                        color: "transparent"
                    }
                }
            }

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 14

                Rectangle {
                    Layout.alignment: Qt.AlignHCenter
                    width: 72
                    height: 72
                    radius: width / 2
                    color: chatBackend.isDarkMode
                        ? Qt.rgba(56, 189, 248, 0.15)
                        : Qt.rgba(14, 165, 233, 0.12)

                    Image {
                        anchors.centerIn: parent
                        width: 38
                        height: 38
                        source: icon
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                    }
                }

                Label {
                    Layout.alignment: Qt.AlignHCenter
                    text: title
                    font.pixelSize: 20
                    font.weight: Font.Medium
                    color: chatBackend.isDarkMode ? "#f1f5f9" : "#1e293b"
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: stackLayout.currentIndex = index
            }
        }
    }
}
