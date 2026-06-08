import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
  id: root
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData
      anchors {
        top: true
        left: true
        right: true
      }
      implicitHeight: Theme.height
      color: "transparent"

      RowLayout {
        anchors.fill: parent
        spacing: 10

        CpuWidget {}
        DiskWidget {}
        MemoryWidget {}
        Item { Layout.fillWidth:true }
        WorkSpace{}
        Item { Layout.fillWidth:true }
        NetworkWidget {}
        BatteryWidget {}
        TimeWidget {}
      }
    }
  }
}
