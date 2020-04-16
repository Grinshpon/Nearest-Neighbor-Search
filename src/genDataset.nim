import parseopt
import strutils
import random

when isMainModule:
  var
    n = 0 # number of points
    k = 0 # dimension
    r = 0.0 # range of values
  for kind,key,val in getopt():
    case kind:
    of cmdArgument:
      n = parseInt(key)
    of cmdLongOption, cmdShortOption:
      #echo key,val
      case key:
      of "k","K","d","D":
        k = parseInt(val)
      of "r","range":
        r = parseFloat(val)
      else:
        k = 2 # default
        r = 1000.0
    of cmdEnd:
      echo ""
  echo "generating file with " & $n & " " & $k & "-dimensional points from range [" & $(-r) & ", " & $r & "]"

  randomize()
  var points: seq[string] = @[]
  for i in 1..n:
    var s = ""
    for j in 0..(k-1):
      s.add($rand((-r)..r))
      if j < (k-1):
        s.add(" ")
    points.add(s)
  let f = open("dataset.txt", fmWrite)

  for point in points:
    f.writeLine(point)
  f.close()

