import util
import kdtree

import strutils
import sequtils

func seqToVec[K: usize](s: seq[float]): Vec[K] =
  if uint(s.len) == K:
    for i in 0..(K-1):
      result[i] = s[i]

proc readDataset*[K: usize](): seq[Vec[K]] =
  var
    f: File
    line: string
  if open(f, "dataset.txt"):
    while f.readLine(line):
      let point = seqToVec[K](line.split(" ").map(parseFloat))
      result.add(point)
