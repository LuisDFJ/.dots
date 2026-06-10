pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root
  property string res
  Cli {
    cmd: "cpu"
    time: 1000
    onCallCompleted: output => root.res = output
  }
}
