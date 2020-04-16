import kdtree
import plotly
import chroma

const D2: uint = 2

proc plotTree2*(tree: Tree[D2], q,p: Vec[D2], r1: float, r2: float)=
  var
    colors = @[Color(r:1.0, g:0.0, b:0.0, a: 1.0), Color(r:0.0, g:1.0, b:0.0, a: 1.0), Color(r:0.0, g:0.0, b:0.0, a: 1.0)]
    d = Trace[float](mode: PlotMode.Markers, `type`: PlotType.Scatter)
    traces: seq[Trace[float]]
    size = @[16.float] #@[(tree.size).float]


  var e = Trace[float](mode: PlotMode.LinesMarkers, `type`: PlotType.Scatter)
  e.marker =Marker[float](size: size, color: colors)
  e.xs = @[q[0], p[0]]
  e.ys = @[q[1], p[1]]
  e.text = @["point q","nearest neighbor"]
  traces.add(e)

  d.marker =Marker[float](size: size)
  for node in tree.nodes:
    if node.val != p:
      d.xs.add(node.val[0])
      d.ys.add(node.val[1])

    #var e = Trace[float](mode: PlotMode.Lines, `type`: PlotType.Scatter)
    #e.marker =Marker[float](size: @[2.float])
    #e.xs.add(max(r1,node.val[0]+float(1-node.plane)*r1))
    #e.xs.add(min(r2,node.val[0]+float(1-node.plane)*r2))
    #e.ys.add(max(r1,node.val[1]+float(node.plane)*r1))
    #e.ys.add(min(r2,node.val[1]+float(node.plane)*r2))
    #traces.add(e)

  #d.xs = @[1.0,2.0]
  #d.ys = @[1.0,2.0]

  #e.xs = @[1.0,1.0]
  #e.ys = @[1.0,2.0]
  traces.add(d)

  var layout = Layout(title: "Dataset", width: 800, height: 800,
                      xaxis: Axis(title:"x"),
                      yaxis: Axis(title:"y"), autosize:false)
  var p = Plot[float](layout:layout, traces: traces)
  p.show()
