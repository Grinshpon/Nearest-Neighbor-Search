type usize* = static[uint]

func split*[T](s: seq[T], ix: int): (seq[T],seq[T]) =
  let
    s1 = s[0..(ix-1)]
    s2 = s[(ix+1)..(s.len-1)]
  return (s1,s2)
