import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Item {
  id: root
  property var labels: [
    "\u4e00",
    "\u4e8c",
    "\u4e09",
    "\u56db",
    "\u4e94",
    "\u516d",
    "\u4e03",
    "\u516b",
    "\u4e5d",
    "\u5341",
  ]

  width: 250
  height: Theme.height
  Layout.alignment: Qt.AlignTop

  RowLayout {
    anchors.centerIn: parent
    spacing: 10

    Repeater {
      model: 7
      Rectangle {
        width: 25
        height: 25
        radius: 12.5
        color: Theme.col_bg
        Text {
          id: workspace
          anchors.centerIn: parent
          property var  ws:     Hyprland.workspaces.values.find(w => w.id == index + 1)
          property bool active: Hyprland.focusedWorkspace?.id == (index+1)

          text: root.labels[index]
          color: active ? Theme.col_1 : (ws ? Theme.col_2 : Theme.col_3 )
          font.pixelSize: Theme.font_size
          font.bold: active
          MouseArea {
            anchors.fill: parent
            onClicked: Hyprland.dispatch(
              "hl.dsp.focus({workspace=" + (index + 1) + "})"
            )
          }
        }
      }
    }
  }
}
