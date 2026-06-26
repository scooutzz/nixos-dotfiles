pragma Singleton
import QtQuick

QtObject {
    property color bg: "#191723"
    property color fg: "#e0def4"

    property color surface: "#1f1d2e"
    property color surface_alpha: Qt.rgba(31, 29, 46, 0.5)
    property color on_surface: "#e0def4"
    property color surface_container_highest: "#26233a"
    property color surface_bright: "#6e6a86"

    property color primary: "#ebbcba"
    property color primary_fixed: "#ebbcba"
    property color on_primary: "#26233a"
    property color inverse_primary: "#31748f"
    property color tertiary: "#c4a7e7"
    property color error: "#eb6f92"
    property color warning: "#f6c177"
    property color success: "#9ccfd8"

    property color hover: "#9ccfd8"
    property color selected: "#21202e"
}
