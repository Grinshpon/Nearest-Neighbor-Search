# nearest neighbor search

import util

type
  DistMetric* = proc(x,y:float): float {.noSideEffect.}
