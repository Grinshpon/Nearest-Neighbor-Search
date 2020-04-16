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

  echo $tree
  tree.plotTree2(qPoint, nPoint, -1000.0,1000.0)


when false:
  #echo $data
  # -------------------------------------------------
  let v: Vec[DIM] = [1.0,2.0]
  let t: Tree[DIM] = kdt.new_tree[DIM](v)
  echo $t

  let
    p1: Vec[DIM] = [0.0,-1.0]
    p2: Vec[DIM] = [1.0,2.0]
    p3: Vec[DIM] = [0.5,0.0]
    p4: Vec[DIM] = [0.0,1.0]
    p5: Vec[DIM] = [0.0,0.0]

  var
    pts1 = @[p1,p2,p3]
    pts2 = @[p4,p1,p2,p3]
    pts3 = @[p1,p2,p3,p4]

  #echo $kdt.treeFromPoints(pts2)
  let tree = kdt.treeFromPoints(pts3)
  echo $tree
  echo $tree.nearestSearch(p5,euclidean_squared[DIM])
  # --------------------------------------------------

