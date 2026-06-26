pragma Singleton
import QtQuick

QtObject {
    property color bg: "#1a1b26"
    property color fg: "#c0caf5"

    property color surface: "#24283b"
    property color surface_alpha: Qt.rgba(26, 27, 38, 0.5)
    property color on_surface: "#c0caf5"
    property color on_surface_variant: "#565f89"
    property color surface_container_highest: "#292e42"
    property color surface_bright: "#414868"

    property color primary: "#7aa2f7"
    property color primary_fixed: "#7aa2f7"
    property color on_primary: "#16161e"
    property color inverse_primary: "#bb9af7"
    property color secondary: "#7dcfff"
    property color tertiary: "#9ece6a"
    property color error: "#f7768e"
    property color warning: "#e0af68"
    property color success: "#9ece6a"

    property color selected: "#33467c"
    property color hover: "#292e42"
}
