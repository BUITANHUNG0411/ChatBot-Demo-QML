import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ChatBotDemo

Item {
    id: chatViewRoot

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            Layout.preferredWidth: 250
            Layout.fillHeight: true
            color: Theme_Color.surface

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 15

                Label {
                    text: "AI Configuration"
                    color: Theme_Color.primaryText
                    font.bold: true
                    font.pixelSize: 16
                }

                ComboBox {
                    Layout.fillWidth: true
                    model: ["Gemini 2.5 Flash", "Gemini 1.5 Pro", "Gemini 1.0 Pro"]
                    palette.text: Theme_Color.primaryText
                    palette.buttonText: Theme_Color.primaryText
                    onActivated: chatBackend.setModel(currentText)
                }

                Switch {
                    checked: chatBackend.isDarkMode
                    text: checked ? "Dark mode" : "Light mode"
                    onToggled: chatBackend.isDarkMode = checked
                    palette.windowText: Theme_Color.primaryText
                }

                Label {
                    text: "Temperature"
                    color: Theme_Color.primaryText
                }

                Slider {
                    Layout.fillWidth: true
                    from: 0
                    to: 1
                    value: 0.7
                }

                Button {
                    text: "New Chat"
                    Layout.fillWidth: true
                    palette.buttonText: Theme_Color.primaryText
                    onClicked: chatBackend.clearChat()
                }

                Button {
                    text: "Export Log"
                    Layout.fillWidth: true
                    palette.buttonText: Theme_Color.primaryText
                    onClicked: chatBackend.exportLog()
                }

                Item { Layout.fillHeight: true }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Theme_Color.background

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 0
                spacing: 0

                ListView {
                    id: chatView
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    model: chatBackend.chatModel
                    delegate: Item {
                        width: chatView.width
                        height: messageText.implicitHeight + 40

                        Rectangle {
                            width: parent.width - 40
                            height: parent.height - 10
                            anchors.centerIn: parent
                            color: model.author === "You"
                                ? Theme_Color.accent
                                : Theme_Color.surface
                            radius: 8

                            Text {
                                id: messageText
                                text: "<b>" + model.author + ":</b> " + model.text
                                width: parent.width - 20
                                anchors.centerIn: parent
                                wrapMode: Text.Wrap
                                font.pixelSize: 14
                                color: Theme_Color.primaryText
                            }
                        }
                    }

                    ScrollBar.vertical: ScrollBar {}
                    onCountChanged: chatView.positionViewAtEnd()
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 80
                    color: Theme_Color.surfaceElevated
                    border.color: Theme_Color.borderSubtle

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 15
                        spacing: 10

                        TextField {
                            id: messageInput
                            Layout.fillWidth: true
                            placeholderText: "Type your message here..."
                            font.pixelSize: 14
                            color: Theme_Color.primaryText
                            onAccepted: sendButton.onClicked()
                        }

                        Button {
                            id: sendButton
                            text: "Send"
                            Layout.preferredHeight: 40
                            palette.buttonText: Theme_Color.primaryText
                            onClicked: {
                                chatBackend.sendMessage(messageInput.text)
                                messageInput.clear()
                            }
                        }
                    }
                }
            }
        }
    }
}
