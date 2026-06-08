import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

ClippingRectangle {
  id: root
  required property string label

  height: Theme.height
  radius: Theme.radius
  color: Theme.col_bg
  Layout.alignment: Qt.AlignTop
  Text {
    anchors.centerIn: parent
    color: Theme.col_fg
    font.pixelSize: Theme.font_size
    textFormat: Text.RichText
    text: root.label
  }
}
