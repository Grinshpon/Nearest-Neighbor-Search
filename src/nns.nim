# nearest neighbor search

import util
import kdtree

import math

type
  DistMetric*[K: usize] = (Vec[K],Vec[K]) --> float #proc(x,y:float): float {.noSideEffect.}

func euclideanSquared*[K: usize](p1,p2: Vec[K]): float =
  for i in 0..(K-1):
    result += pow(p2[i]-p1[i],2)

func euclidean*[K: usize](p1,p2: Vec[K]): float =
  result = sqrt(euclidean_squared(p1,p2))

# takes initial point and returns nearest point in tree using supplied distance metric
func nearestSearch*[K: usize](tree: Tree[K], q: Vec[K], dist: DistMetric[K]): Vec[K] =
  var
    currentNode = tree.root
    currentMin = dist(q, currentNode.val)
  while not (isNil(currentNode.left) and isNil(currentNode.right)):
    var
      nextNode = currentNode
      distLeft  = -1.0
      distRight = -1.0
    if not isNil(currentNode.left):
      distLeft = dist(q,currentNode.left.val)
    if not isNil(currentNode.right):
      distRight = dist(q,currentNode.right.val)

    if distLeft > 0.0 and distLeft < currentMin:
      currentMin = distLeft
      nextNode = currentNode.left
    if distRight > 0.0 and distRight < currentMin:
      currentMin = distRight
      nextNode = currentNode.right
    if nextNode == currentNode:
      return currentNode.val
    else:
      currentNode = nextNode

  return currentNode.val
