import kdtree as kdt
import nns
import readData
import plot

#import plotly
#import chroma


when isMainModule:
  const DIM: uint = 2

  var
    data = readDataset[DIM]()
    tree = kdt.treeFromPoints(data)
  let
    qPoint: Vec[DIM] = [4.0,5.0]
    nPoint = tree.nearestSearch(qPoint, euclidean_squared[DIM])

  #echo $tree
  tree.plotTree2(qPoint, nPoint, -1000.0,1000.0)
