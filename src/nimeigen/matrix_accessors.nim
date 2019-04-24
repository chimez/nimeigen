# this file include complex accessors
# 1. m[1..2], m[1..2]=v
# 2. m[1..2,3..4], m[1..2,3..4]=v

import complex
import ./matrix, ./matrix_operators

type UnderLine* = object
const _* = UnderLine()
type HSliceIntOrUnderLine = HSlice[int,int] or HSlice[int,UnderLine] or HSlice[UnderLine,int] or HSlice[UnderLine,UnderLine]

template accessors(matrix_type, scalar_type:typedesc):typed=
  proc `[]`*(x:matrix_type,s:HSliceIntOrUnderLine):matrix_type=
    when typeof(s.a) is UnderLine:
      let min_index = 0
    else:
      let min_index = s.a
    when typeof(s.b) is UnderLine:
      let max_index = x.rows()
    else:
      var max_index_inner = s.b
      if s.b < 0:
        max_index_inner = x.rows() + s.b
      let max_index = max_index_inner

    var res_seq: seq[seq[scalar_type]] = @[]
    for i in 0..<x.rows():
      if i>=min_index and i<max_index:
        var col_seq: seq[scalar_type] = @[]
        for j in 0..<x.cols():
          col_seq.add(x[i,j])
          # end for j
        res_seq.add(col_seq)
      # end for i
    result=matrix(res_seq, dtype=scalar_type)

  proc `[]=`*(x:var matrix_type,s:HSliceIntOrUnderLine,v:matrix_type)=
    when typeof(s.a) is UnderLine:
      let min_index = 0
    else:
      let min_index = s.a
    when typeof(s.b) is UnderLine:
      let max_index = x.rows()
    else:
      var max_index_inner = s.b
      if s.b < 0:
        max_index_inner = x.rows() + s.b
      let max_index = max_index_inner

    if (x.cols()!=v.cols()) or (max_index-min_index)!=v.rows():
      raise newException(IndexError, "matrix shapes are different")

    var
      vi = 0
      vj = 0
    for i in 0..<x.rows():
      if i>=min_index and i<max_index:
        for j in 0..<x.cols():
          x[i,j] = v[vi,vj]
          vj = vj + 1
          # end for j
        vi = vi + 1
        vj = 0

  proc `[]`*(x:matrix_type,s1,s2:HSliceIntOrUnderLine):matrix_type=
    when typeof(s1.a) is UnderLine:
      let s1_min_index = 0
    else:
      let s1_min_index = s1.a
    when typeof(s1.b) is UnderLine:
      var s1_max_index_inner = s1.b
      if s1.b < 0:
        s1_max_index_inner = x.rows() + s1.b
      let s1_max_index = s1_max_index_inner
    else:
      let s1_max_index = s1.b
    when typeof(s2.a) is UnderLine:
      let s2_min_index = 0
    else:
      let s2_min_index = s2.a
    when typeof(s2.b) is UnderLine:
      let s2_max_index = x.rows()
    else:
      var s2_max_index_inner = s2.b
      if s2.b < 0:
        s2_max_index_inner = x.rows() + s2.b
      let s2_max_index = s2_max_index_inner


    var res_seq: seq[seq[scalar_type]] = @[]
    for i in 0..<x.rows():
      if i>=s1_min_index and i<s1_max_index:
        var col_seq: seq[scalar_type] = @[]
        for j in 0..<x.cols():
          if j>=s2_min_index and j<s2_max_index:
            col_seq.add(x[i,j])
          # end for j
        res_seq.add(col_seq)
      # end for i
    result=matrix(res_seq, dtype=scalar_type)

  proc `[]=`*(x:var matrix_type,s1,s2:HSliceIntOrUnderLine, v:matrix_type)=
    when typeof(s1.a) is UnderLine:
      let s1_min_index = 0
    else:
      let s1_min_index = s1.a
    when typeof(s1.b) is UnderLine:
      let s1_max_index = x.rows()
    else:
      var s1_max_index_inner = s1.b
      if s1.b < 0:
        s1_max_index_inner = x.rows() + s1.b
      let s1_max_index = s1_max_index_inner
    when typeof(s2.a) is UnderLine:
      let s2_min_index = 0
    else:
      let s2_min_index = s2.a
    when typeof(s2.b) is UnderLine:
      let s2_max_index = x.rows()
    else:
      var s2_max_index_inner = s2.b
      if s2.b < 0:
        s2_max_index_inner = x.rows() + s2.b
      let s2_max_index = s2_max_index_inner

    if (s2_max_index-s2_min_index)!=v.cols() or (s1_max_index-s1_min_index)!=v.rows():
      raise newException(IndexError, "matrix shapes are different")

    var
      vi = 0
      vj = 0
    for i in 0..<x.rows():
      if i>=s1_min_index and i<s1_max_index:
        for j in 0..<x.cols():
          if j>=s2_min_index and j<s2_max_index:
            x[i,j] = v[vi,vj]
            vj = vj + 1
          # end for j
        vi = vi + 1
        vj = 0

  proc `[]`*(x:matrix_type, index:int):matrix_type=
    var index_new = index
    if index < 0:
      index_new = x.rows() + index
    result = x[index_new..(index_new+1)]
  proc `[]=`*(x:var matrix_type, index:int, v:matrix_type)=
    var index_new = index
    if index < 0:
      index_new = x.rows() + index
    x[index_new..(index_new+1)] = v


accessors(MatrixXcd, Complex[float64])
accessors(MatrixXcf, Complex[float32])
accessors(MatrixXd, float64)
accessors(MatrixXf, float32)



