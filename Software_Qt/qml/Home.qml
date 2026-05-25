import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ChatBotDemo

Rectangle {
    id: root
    color: Theme_Color.background

    GridView {
        anchors.fill: parent
        anchors.margins: 40
        anchors.leftMargin: 60
        cellWidth: 280
        cellHeight: 220

        model: ListModel {
            ListElement {
                title: "Cluster"
                icon: "../assets/cluster.svg"
                index: 1
            }
            ListElement {
                title: "Chat"
                icon: "../assets/chat.svg"
                index: 2
            }
            ListElement {
                title: "Note"
                icon: "../assets/note.svg"
                index: 3
            }
            ListElement {
                title: "Weather"
                icon: "../assets/weather.svg"
                index: 4
            }
            ListElement {
                title: "Map"
                icon: "../assets/map.svg"
                index: 5
            }
            ListElement {
                title: "Contact"
                icon: "../assets/contact.svg"
                index: 6
            }
            ListElement {
                title: "Music"
                icon: "../assets/music.svg"
                index: 7
            }
        }

        delegate: Rectangle {
            width: 260
            height: 200
            radius: 24
            color: Theme_Color.surfaceElevated
            border.width: 1
            border.color: Theme_Color.borderSubtle
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
                        color: Theme_Color.surfaceOverlay
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
                    color: Theme_Color.accentMuted

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
                    color: Theme_Color.primaryText
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
