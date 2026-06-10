pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root
  property string res
  Cli {
    cmd: "time"
    time: 1000
    onCallCompleted: output => root.res = output
  }
}
