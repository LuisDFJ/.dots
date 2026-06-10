pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root
  property string res
  Cli {
    cmd: "memory"
    time: 20000
    onCallCompleted: output => root.res = output
  }
}
