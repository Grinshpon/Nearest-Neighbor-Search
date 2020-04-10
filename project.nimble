# Package

version       = "0.1.0"
author        = "grinshpon"
description   = "Nearest Neighbor Search using kd-trees"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["project"]



# Dependencies

requires "nim >= 1.2.0", "plotly", "chroma"
