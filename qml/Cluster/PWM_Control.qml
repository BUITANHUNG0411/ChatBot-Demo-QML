import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ChatBotDemo

Item {
    id: root
    implicitWidth: 800
    implicitHeight: 600

    property real motor1PWM: motor1Slider.value
    property real motor2PWM: motor2Slider.value
    property real elapsedSeconds: 0

    Timer {
        id: chartTimer
        interval: 100
        running: false
        repeat: true
        onTriggered: {
            elapsedSeconds += 0.1
            chartCanvas.requestPaint()
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 16

        // === Part 1: Chart ===
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignTop
            spacing: 8

            Label {
                text: "Real-Time PWM"
                font.pixelSize: 22
                font.weight: Font.Bold
                font.family: "Segoe UI"
                color: Theme_Color.primaryText
                Layout.alignment: Qt.AlignHCenter
            }

            Rectangle {
                id: chartContainer
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumHeight: 220
                color: Theme_Color.surface
                border.color: Theme_Color.borderColor
                border.width: 1
                radius: 8

                Canvas {
                    id: chartCanvas
                    anchors.fill: parent
                    anchors.margins: 12

                    onPaint: {
                        const ctx = getContext("2d");
                        ctx.clearRect(0, 0, width, height);

                        const chartLeft = 0;
                        const chartRight = width;
                        const chartTop = 0;
                        const chartBottom = height;

                        const pwmMin = 0;
                        const pwmMax = 110;
                        const timeWindow = 50;

                        function toChartX(t) {
                            return chartLeft + (t / timeWindow) * chartRight;
                        }
                        function toChartY(pwm) {
                            return chartBottom - (pwm / pwmMax) * chartBottom;
                        }

                        // Draw grid lines
                        ctx.strokeStyle = Theme_Color.borderColor;
                        ctx.lineWidth = 0.5;
                        for (let p = 0; p <= 110; p += 22) {
                            const y = toChartY(p);
                            ctx.beginPath();
                            ctx.moveTo(chartLeft, y);
                            ctx.lineTo(chartRight, y);
                            ctx.stroke();
                        }
                        for (let s = 0; s <= 50; s += 10) {
                            const x = toChartX(s);
                            ctx.beginPath();
                            ctx.moveTo(x, chartTop);
                            ctx.lineTo(x, chartBottom);
                            ctx.stroke();
                        }

                        // Motor 1 line (accent color)
                        const startTime1 = Math.max(elapsedSeconds - timeWindow, 0);
                        ctx.beginPath();
                        ctx.strokeStyle = Theme_Color.accent;
                        ctx.lineWidth = 2;
                        let first = true;
                        const step = 0.2;
                        for (let t = startTime1; t <= elapsedSeconds; t += step) {
                            const sinVal = Math.sin(t * 0.5) * 30 + 55;
                            const pwm = Math.max(0, Math.min(110, sinVal + motor1PWM * 0.5));
                            const x = toChartX(t - startTime1);
                            const y = toChartY(pwm);
                            if (first) { ctx.moveTo(x, y); first = false; }
                            else ctx.lineTo(x, y);
                        }
                        ctx.stroke();

                        // Motor 2 line (secondary text color)
                        ctx.beginPath();
                        ctx.strokeStyle = Theme_Color.secondaryText;
                        ctx.lineWidth = 2;
                        first = true;
                        for (let t = startTime1; t <= elapsedSeconds; t += step) {
                            const sinVal = Math.sin(t * 0.5 + Math.PI * 0.5) * 30 + 55;
                            const pwm = Math.max(0, Math.min(110, sinVal + motor2PWM * 0.5));
                            const x = toChartX(t - startTime1);
                            const y = toChartY(pwm);
                            if (first) { ctx.moveTo(x, y); first = false; }
                            else ctx.lineTo(x, y);
                        }
                        ctx.stroke();

                        // Axis labels
                        ctx.fillStyle = Theme_Color.secondaryText;
                        ctx.font = "10px Segoe UI";
                        for (let p = 0; p <= 110; p += 22) {
                            const y = toChartY(p);
                            ctx.fillText(p, chartLeft + 2, y - 2);
                        }
                        for (let s = 0; s <= 50; s += 10) {
                            const x = toChartX(s);
                            ctx.fillText(s + "s", x - 8, chartBottom - 2);
                        }
                    }
                }
            }

            // Legend
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 20

                Rectangle {
                    width: 20
                    height: 3
                    color: Theme_Color.accent
                    radius: 2
                }
                Label {
                    text: "Motor 1"
                    font.pixelSize: 11
                    font.family: "Segoe UI"
                    color: Theme_Color.secondaryText
                }
                Rectangle {
                    width: 20
                    height: 3
                    color: Theme_Color.secondaryText
                    radius: 2
                }
                Label {
                    text: "Motor 2"
                    font.pixelSize: 11
                    font.family: "Segoe UI"
                    color: Theme_Color.secondaryText
                }
            }
        }

        // === Part 2: PWM Control ===
        Rectangle {
            Layout.fillWidth: true
            Layout.minimumHeight: 220
            color: Theme_Color.surface
            border.color: Theme_Color.borderColor
            border.width: 1
            radius: 8
            Layout.margins: 8

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 12

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 16

                    // Motor 1
                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignVCenter
                        spacing: 6

                        Label {
                            text: "Motor 1"
                            font.pixelSize: 14
                            font.weight: Font.Bold
                            font.family: "Segoe UI"
                            color: Theme_Color.primaryText
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Slider {
                            id: motor1Slider
                            from: 0
                            to: 110
                            value: 55
                            stepSize: 1
                            orientation: Qt.Vertical
                            implicitWidth: 50
                            implicitHeight: 120
                            Layout.alignment: Qt.AlignHCenter

                            background: Rectangle {
                                x: parent.leftPadding + parent.availableWidth / 2 - width / 2
                                implicitWidth: 6
                                implicitHeight: parent.availableHeight
                                y: parent.topPadding
                                height: parent.availableHeight
                                radius: 3
                                color: Theme_Color.gaugeInactive
                            }

                            handle: Rectangle {
                                x: parent.leftPadding + parent.availableWidth / 2 - width / 2
                                y: parent.topPadding + parent.visualPosition * parent.availableHeight - height / 2
                                implicitWidth: 18
                                implicitHeight: 18
                                radius: 9
                                color: Theme_Color.accent
                            }
                        }

                        Label {
                            text: motor1Slider.value.toFixed(0)
                            font.pixelSize: 13
                            font.weight: Font.Bold
                            font.family: "Segoe UI"
                            color: Theme_Color.accent
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }

                    Rectangle {
                        Layout.fillHeight: true
                        width: 1
                        color: Theme_Color.borderColor
                    }

                    // Motor 2
                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignVCenter
                        spacing: 6

                        Label {
                            text: "Motor 2"
                            font.pixelSize: 14
                            font.weight: Font.Bold
                            font.family: "Segoe UI"
                            color: Theme_Color.primaryText
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Slider {
                            id: motor2Slider
                            from: 0
                            to: 110
                            value: 55
                            stepSize: 1
                            orientation: Qt.Vertical
                            implicitWidth: 50
                            implicitHeight: 120
                            Layout.alignment: Qt.AlignHCenter

                            background: Rectangle {
                                x: parent.leftPadding + parent.availableWidth / 2 - width / 2
                                implicitWidth: 6
                                implicitHeight: parent.availableHeight
                                y: parent.topPadding
                                height: parent.availableHeight
                                radius: 3
                                color: Theme_Color.gaugeInactive
                            }

                            handle: Rectangle {
                                x: parent.leftPadding + parent.availableWidth / 2 - width / 2
                                y: parent.topPadding + parent.visualPosition * parent.availableHeight - height / 2
                                implicitWidth: 18
                                implicitHeight: 18
                                radius: 9
                                color: Theme_Color.secondaryText
                            }
                        }

                        Label {
                            text: motor2Slider.value.toFixed(0)
                            font.pixelSize: 13
                            font.weight: Font.Bold
                            font.family: "Segoe UI"
                            color: Theme_Color.secondaryText
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: Theme_Color.borderColor
                }

                // Buttons Row
                RowLayout {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 12

                    Button {
                        id: startBtn
                        text: "Start"
                        font.pixelSize: 13
                        font.family: "Segoe UI"
                        font.weight: Font.Medium
                        implicitWidth: 120
                        implicitHeight: 36

                        background: Rectangle {
                            color: Theme_Color.accent
                            radius: 6
                        }
                        contentItem: Label {
                            text: parent.text
                            font: parent.font
                            color: Theme_Color.glassText
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        onClicked: {
                            if (!chartTimer.running) {
                                chartTimer.running = true
                            }
                        }
                    }

                    Button {
                        id: stopBtn
                        text: "Stop"
                        font.pixelSize: 13
                        font.family: "Segoe UI"
                        font.weight: Font.Medium
                        implicitWidth: 120
                        implicitHeight: 36

                        background: Rectangle {
                            color: Theme_Color.danger
                            radius: 6
                        }
                        contentItem: Label {
                            text: parent.text
                            font: parent.font
                            color: Theme_Color.glassText
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        onClicked: {
                            chartTimer.running = false
                        }
                    }

                    Button {
                        id: resetBtn
                        text: "Reset Encoder"
                        font.pixelSize: 13
                        font.family: "Segoe UI"
                        font.weight: Font.Medium
                        implicitWidth: 120
                        implicitHeight: 36

                        background: Rectangle {
                            color: Theme_Color.surfaceOverlay
                            border.color: Theme_Color.borderColor
                            border.width: 1
                            radius: 6
                        }
                        contentItem: Label {
                            text: parent.text
                            font: parent.font
                            color: Theme_Color.primaryText
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        onClicked: {
                            elapsedSeconds = 0
                            motor1Slider.value = 55
                            motor2Slider.value = 55
                            chartTimer.running = false
                            chartCanvas.requestPaint()
                        }
                    }
                }
            }
        }
    }
}
