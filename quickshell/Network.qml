pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root
  property string res
  Cli {
    cmd: "network"
    time: 5000
    onCallCompleted: output => root.res = output
  }
}
