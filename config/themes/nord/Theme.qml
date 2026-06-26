pragma Singleton
import QtQuick

QtObject {
    property color bg: "#2E3440"
    property color fg: "#D8DEE9"

    property color surface: "#3B4252"
    property color surface_alpha: Qt.rgba(59, 66, 82, 0.5)
    property color on_surface: "#D8DEE9"
    property color surface_container_highest: "#434C5E"
    property color surface_bright: "#4C566A"

    property color primary: "#88C0D0"
    property color primary_fixed: "#88C0D0"
    property color on_primary: "#2E3440"
    property color inverse_primary: "#81A1C1"
    property color tertiary: "#8FBCBB"
    property color error: "#BF616A"
    property color warning: "#EBCB8B"
    property color success: "#A3BE8C"

    property color hover: "#D08770"
    property color selected: "#434C5E"
}
