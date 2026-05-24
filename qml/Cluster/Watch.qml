import QtQuick
import QtQuick.Controls
import ChatBotDemo

Item {
    id: root
    implicitWidth: parent && parent.width > 0 ? Math.min(parent.width, parent.height) * 0.85 : 300
    implicitHeight: implicitWidth

    property real value: 0
    property real maxValue: 100
    property int segmentCount: 20
    property color activeColor: Theme_Color.accent
    property color inactiveColor: Theme_Color.gaugeInactive
    property color outerColor: Theme_Color.gaugeOuter
    property real outerRadius: root.width / 2 - 10
    property real innerRadius: outerRadius * 0.68
    property real outerThickness: (outerRadius - innerRadius) * 0.45
    property real innerThickness: outerThickness
    property real startAngleDeg: -210
    property real sweepDeg: 240

    readonly property real percentage: Math.min(Math.max(value / maxValue, 0), 1)
    readonly property int activeSegments: Math.round(percentage * segmentCount)

    Canvas {
        id: canvas
        anchors.fill: parent

        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()

        onPaint: {
            const ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            const cx = width / 2;
            const cy = height / 2;

            const segGap = 3;
            const outerMid = (outerRadius - innerRadius / 2);
            const outerSegLen = (outerThickness - segGap);

            drawRing(ctx, cx, cy, outerMid, outerSegLen, segmentCount, segmentCount,
                     startAngleDeg, sweepDeg, outerColor);

            const innerMid = outerMid - (outerThickness / 2);
            const innerSegLen = outerThickness - segGap;

            drawRing(ctx, cx, cy, innerMid, innerSegLen, segmentCount, activeSegments,
                     startAngleDeg, sweepDeg, activeColor);
        }

        function degToRad(deg) {
            return deg * Math.PI / 180;
        }

        function drawRing(ctx, cx, cy, radius, segLen, totalSegs, litSegs, startDeg, sweep, color) {
            const arcPerSeg = sweep / totalSegs;
            const segAngleRad = degToRad(arcPerSeg - 1.5);
            const segOuterR = radius + segLen / 2;
            const segInnerR = radius - segLen / 2;

            for (let i = 0; i < totalSegs; i++) {
                const segMidAngle = degToRad(startDeg + (i + 0.5) * arcPerSeg);
                const startAngle = segMidAngle - segAngleRad / 2;
                const endAngle = segMidAngle + segAngleRad / 2;

                const x1 = cx + segInnerR * Math.cos(startAngle);
                const y1 = cy - segInnerR * Math.sin(startAngle);
                const x2 = cx + segOuterR * Math.cos(startAngle);
                const y2 = cy - segOuterR * Math.sin(startAngle);
                const x3 = cx + segOuterR * Math.cos(endAngle);
                const y3 = cy - segOuterR * Math.sin(endAngle);
                const x4 = cx + segInnerR * Math.cos(endAngle);
                const y4 = cy - segInnerR * Math.sin(endAngle);

                ctx.beginPath();
                ctx.moveTo(x1, y1);
                ctx.lineTo(x2, y2);
                ctx.lineTo(x3, y3);
                ctx.lineTo(x4, y4);
                ctx.closePath();
                ctx.fillStyle = (i < litSegs) ? color : inactiveColor;
                ctx.fill();
            }
        }
    }

    Label {
        anchors.centerIn: parent
        text: root.value.toFixed(0)
        font.pixelSize: root.width * 0.22
        font.weight: Font.Bold
        font.family: "Segoe UI"
        color: Theme_Color.primaryText
    }

    Label {
        anchors.top: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: root.width * 0.08
        text: root.maxValue
        font.pixelSize: root.width * 0.09
        font.weight: Font.Medium
        font.family: "Segoe UI"
        color: Theme_Color.secondaryText
    }

    Label {
        anchors.bottom: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: root.width * 0.08
        text: "0"
        font.pixelSize: root.width * 0.09
        font.weight: Font.Medium
        font.family: "Segoe UI"
        color: Theme_Color.secondaryText
    }

    Label {
        id: motorLabel
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -root.width * 0.06
        text: root.percentage > 0
              ? (root.percentage * 100).toFixed(0) + "%"
              : ""
        font.pixelSize: root.width * 0.08
        font.weight: Font.Medium
        font.family: "Segoe UI"
        color: Theme_Color.accent
        visible: root.value > 0
    }

    onValueChanged: canvas.requestPaint()
    onActiveColorChanged: canvas.requestPaint()
    onInactiveColorChanged: canvas.requestPaint()
    onOuterColorChanged: canvas.requestPaint()
}
