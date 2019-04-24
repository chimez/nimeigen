# This file contains logic functions
# 1. isclose, allclose
import complex
import ./matrix, ./matrix_operators

proc isclose*[T:MatrixType](a, b:T, rtol=1e-05, atol=1e-08):seq[seq[bool]]=
  ## https://docs.scipy.org/doc/numpy/reference/generated/numpy.isclose.html
  if a.rows != b.rows or a.cols() != b.cols():
    raise newException(ValueError, "different matrix size")

  var res = newSeq[seq[bool]](a.rows())
  for i in 0..<a.rows():
    var res_col = newSeq[bool](a.cols())
    for j in 0..<a.cols():
      res_col[j] = (abs(a[i,j]-b[i,j]) <= atol + rtol * abs(b[i,j]))
    res[i] = res_col

  result = res
  return res

proc allclose*[T:MatrixType](a, b:T, rtol=1e-05, atol=1e-08):bool=
  let res = isclose(a,b,rtol,atol)
  result = true
  for y in res:
    for x in y:
      if not x:
        result = false

  return

proc maximum*[T:MatrixXd or MatrixXf](a, b:T):T=
  result = a
  for i in 0..<a.rows():
    for j in 0..<a.cols():
      if a[i,j] > b[i,j]:
        result[i,j] = a[i,j]
      else:
        result[i,j] = b[i,j]
