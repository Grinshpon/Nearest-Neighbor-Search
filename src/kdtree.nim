#import options
import algorithm

import util

type
  Vec*[K: usize] = array[K, float]
  Node[K: usize] = ref object
    val*: Vec[K]
    plane*: uint
    left*,right*: Node[K]#Option[Node[K]]
  Tree*[K: usize] = object
    root*: Node[K]
    dim*: uint
    size*: uint
    height*: uint

func newTree*[K: usize](v: Vec[K]): Tree[K] =
  result.root = Node[K](val: v, plane: 0, left: nil, right: nil)
  result.dim = K
  result.height = 1
  result.size = 1

func emptyTree*[K: usize](): Tree[K] =
  result.dim = K
  result.height = 0
  result.size = 0

func sortBy[K: usize](d: uint): auto = (proc(v1,v2: Vec[K]):int = system.cmp(v1[d],v2[d]))

proc insert[K: usize](node: var Node[K], points: var seq[Vec[K]]): uint =
  if points.len == 0 or node == nil:
    return 0
  let r = (node.plane + 1) mod K
  var
    (lPoints, rPoints) = split(points, points.len div 2)
  lPoints.sort(sortBy[K](r))
  rPoints.sort(sortBy[K](r))
  let
    lMid = lPoints.len div 2
    rMid = rPoints.len div 2
  if lPoints.len > 0:
    node.left  = Node[K](val: lPoints[lMid], plane: r)
  if rPoints.len > 0:
    node.right = Node[K](val: rPoints[rMid], plane: r)
  return 1+max(node.left.insert(lPoints), node.right.insert(rPoints))

proc treeFromPoints*[K: usize](points: var seq[Vec[K]]): Tree[K] =
  let size = points.len
  result.size = uint(points.len)
  if size == 1:
    return newTree[K](points[0])

  points.sort(sortBy[K](0))
  #echo points
  result.dim = K
  let mid = size div 2

  result.root = Node[K](val: points[mid], plane: 0)
  result.height += 1

  let h = result.root.insert(points)
  result.height += h

func showNode[K: usize](n: Node[K]): string =
  result = "Node(val: " & $n.val
  if n.left != nil:
    result &= ", left: " & showNode[K](n.left)
  if n.right != nil:
    result &= ", right: " & showNode[K](n.right)
  result &= ")"

func showTree[K: usize](t: Tree[K]): string =
  if t.height > 0:
    result = $t.dim & "-Tree(" & showNode[K](t.root)
  else:
    result = $t.dim & "-Tree(empty)"

func `$`*[K](t: Tree[K]): string =
  showTree(t)

func `$`*[K](t: Node[K]): string =
  showNode(t)

iterator nodes*[K](tree: Tree[K]): Node[K] =
  var
    stack: seq[Node[K]]
    current: Node[K]

  stack.add(tree.root)
  while stack.len > 0:
    current = stack.pop()
    yield current

    if not isNil(current.right):
      stack.add(current.right)
    if not isNil(current.left):
      stack.add(current.left)

