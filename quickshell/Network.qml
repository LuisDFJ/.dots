pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  property string res
  Process {
    id: proc
    command: [Quickshell.env("HOME") + "/.config/quickshell/cli/target/release/cli", "network"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: root.res = this.text
    }
  }
  Timer {
    interval: 5000
    running: true
    repeat: true
    onTriggered: proc.running = true
  }
}
