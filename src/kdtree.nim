#import options

import util

type
  Ring = object
    d: uint #dim
    n: uint #val

func addr(lhs: Ring, rhs: uint): Ring =
  result.d = lhs.d
  result.n = (lhs.n + rhs) mod lhs.d

func subr(lhs: Ring, rhs: uint): Ring =
  result.d = lhs.d
  result.n = (lhs.n - rhs) mod lhs.d

type
  Vec*[K: usize] = array[K, float]
  Node[K: usize] = ref object
    val: Vec[K]
    plane: Ring
    left,right: Node[K]#Option[Node[K]]
  Tree*[K: usize] = object
    root: Node[K]
    dim: uint
    height: uint

func newTree*[K: usize](v: Vec[K]): Tree[K] =
  result.root = Node[K](val: v, plane: Ring(d: K, n: 0), left: nil, right: nil)
  result.dim = K
  result.height = 1

func emptyTree*[K: usize](): Tree[K] =
  result.dim = K
  result.height = 0

# replace echo statements with actual tree insertion and then turn proc into func
proc treeFromPoints*[K: usize](points: seq[Vec[K]]): Tree[K] = # Assumes the sequence of points is sorted
  let size = points.len
  if size == 1:
    return newTree[K](points[0])
  result.dim = K
  let mid = size div 2

  # ... add in midpoint
  echo mid
  # ...

  if size mod 2 == 1:
    for i in countup(1,mid):
      if mid + i < size:
        echo (mid + i)
      if mid - i >= 0:
        echo (mid - i)
  else:
    for i in countup(1,mid):
      if mid-i >= 0:
        echo (mid - i)
      if mid+i < size:
        echo (mid + i)

func showNode[K: usize](n: Node[K]): string =
  result = "Node(val: " & $n.val
  if n.left != nil:
    result &= ", left: " & showNode[K](n.left)
  if n.right != nil:
    result &= ", right: " & showNode[K](n.right)
  result &= ")"

func showTree*[K: usize](t: Tree[K]): string =
  if t.height > 0:
    result = $t.dim & "-Tree(" & showNode[K](t.root)
  else:
    result = $t.dim & "-Tree(empty)"

func `$`*[K](t: Tree[K]): string =
  showTree(t)
