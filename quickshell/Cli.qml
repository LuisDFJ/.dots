import Quickshell
import Quickshell.Io
import QtQuick

Item {
  id: root
  required property string cmd
  required property int time

  signal callCompleted(output : string)

  Process {
    id: proc
    command: [Quickshell.env("HOME") + "/.config/quickshell/cli/target/release/cli", root.cmd, Theme.theme]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        root.callCompleted(this.text)
      }
    }
  }
  Timer {
    interval: root.time
    running: true
    repeat: true
    onTriggered: proc.running = true
  }
}
