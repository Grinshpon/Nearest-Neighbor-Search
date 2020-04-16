import kdtree as kdt
import nns
import readData

import plotly
import chroma


when isMainModule:
  const DIM: uint = 2

  var
    data = readDataset[DIM]()
    tree = kdt.treeFromPoints(data)

  

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

  var colors = @[Color(r:0.9, g:0.4, b:0.0, a: 1.0),
                 Color(r:0.9, g:0.4, b:0.2, a: 1.0),
                 Color(r:0.2, g:0.9, b:0.2, a: 1.0),
                 Color(r:0.1, g:0.7, b:0.1, a: 1.0),
                 Color(r:0.0, g:0.5, b:0.1, a: 1.0)]
  var d = Trace[int](mode: PlotMode.LinesMarkers, `type`: PlotType.Scatter)
  var size = @[16.int]
  d.marker =Marker[int](size:size, color: colors)
  d.xs = @[1, 2, 3, 4, 5]
  d.ys = @[1, 2, 1, 9, 5]
  d.text = @["hello", "data-point", "third", "highest", "<b>bold</b>"]

  var e = Trace[int](mode: PlotMode.LinesMarkers, `type`: PlotType.Scatter)
  e.marker = Marker[int](size:size, color: colors)
  e.xs = @[1,3]
  e.ys = @[2,4]
  e.text = @["one", "two"]

  var layout = Layout(title: "testing", width: 1200, height: 400,
                      xaxis: Axis(title:"my x-axis"),
                      yaxis:Axis(title: "y-axis too"), autosize:false)
  var p = Plot[int](layout:layout, traces: @[d,e])
  #p.show()
