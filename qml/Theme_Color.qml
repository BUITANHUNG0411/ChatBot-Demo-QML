pragma Singleton
import QtQuick

Rectangle {
    id: themeRoot
    visible: false
    color: "transparent"

    readonly property bool isDark: chatBackend ? chatBackend.isDarkMode : false

    // Light Green palette
    readonly property color light_background:     "#f0fdf4"
    readonly property color light_surface:       "#ffffff"
    readonly property color light_primaryText:   "#064e3b"
    readonly property color light_secondaryText: "#166534"
    readonly property color light_accent:        "#22c55e"
    readonly property color light_borderColor:  "#bbf7d0"

    // Dark Green palette
    readonly property color dark_background:     "#0f2a1a"
    readonly property color dark_surface:        "#14532d"
    readonly property color dark_primaryText:    "#d1fae5"
    readonly property color dark_secondaryText:  "#6bc091"
    readonly property color dark_accent:         "#4ade80"
    readonly property color dark_borderColor:    "#166534"

    property color background:     isDark ? dark_background    : light_background
    property color surface:      isDark ? dark_surface       : light_surface
    property color primaryText:  isDark ? dark_primaryText   : light_primaryText
    property color secondaryText: isDark ? dark_secondaryText : light_secondaryText
    property color accent:       isDark ? dark_accent        : light_accent
    property color borderColor:  isDark ? dark_borderColor   : light_borderColor

    // Additional semantic colors used across components
    property color surfaceElevated:  isDark ? "#0f2f21" : "#ffffff"
    property color borderSubtle:      isDark ? "#334155" : "#cbd5e1"
    property color accentMuted:     isDark ? Qt.rgba(74/255, 222/255, 128/255, 0.15) : Qt.rgba(34/255, 197/255, 94/255, 0.12)
    property color surfaceOverlay:  isDark ? Qt.rgba(255/255, 255/255, 255/255, 0.05) : Qt.rgba(255/255, 255/255, 255/255, 0.4)

    // Danger/destructive color (used in hover states)
    property color danger:         "#ef4444"
    property color dangerMuted:    isDark ? Qt.rgba(127/255, 29/255, 29/255, 0.6) : Qt.rgba(254/255, 226/255, 226/255, 0.8)

    // Gauge/arc inactive segment color
    property color gaugeInactive:   isDark ? Qt.rgba(74/255, 222/255, 128/255, 0.12) : Qt.rgba(34/255, 197/255, 94/255, 0.1)
    // Gauge outer ring (always-on segments)
    property color gaugeOuter:       isDark ? Qt.rgba(74/255, 222/255, 128/255, 0.25) : Qt.rgba(34/255, 197/255, 94/255, 0.2)

    // Weather view — gradient background
    property color weatherGradTop:  isDark ? "#0f3d1a" : "#166534"
    property color weatherGradBot:  isDark ? "#0f2a1a" : "#22c55e"

    // Weather view — glass container
    property color glassSurface:    isDark ? Qt.rgba(15/255, 42/255, 26/255, 0.75) : Qt.rgba(255/255, 255/255, 255/255, 0.18)
    property color glassBorder:     isDark ? Qt.rgba(74/255, 222/255, 128/255, 0.25) : Qt.rgba(255/255, 255/255, 255/255, 0.35)
    property color glassDivider:    isDark ? Qt.rgba(74/255, 222/255, 128/255, 0.2)  : Qt.rgba(255/255, 255/255, 255/255, 0.2)
    property color glassText:       "#ffffff"
    property color glassTextMuted:  isDark ? Qt.rgba(209/255, 250/255, 229/255, 0.65) : Qt.rgba(255/255, 255/255, 255/255, 0.7)
}
