# This file contains
# 0. dense MatrixType, savlar type
# 1. create functions: matrix, ones, fill, zeros, rand, linspace, eye
# 2. converter: toSeq, arrayToMatrix, seqToMatrix, astype, real, imag
# 3. getter\setter,
# 4. runtime info functions: rows, cols, size,
# 5. echo functions(toString or $)

include ./stdcomplex

type MatrixXd* {.importcpp:"Eigen::MatrixXd", header:"<Eigen/Core>".} = object
type MatrixXf* {.importcpp:"Eigen::MatrixXf", header:"<Eigen/Core>".} = object
type MatrixXcf* {.importcpp:"Eigen::MatrixXcf", header:"<Eigen/Core>".} = object
type MatrixXcd* {.importcpp:"Eigen::MatrixXcd", header:"<Eigen/Core>".} = object
type MatrixType* = MatrixXf|MatrixXd|MatrixXcd|MatrixXcf
type Scalar* = float32|float64|Complex[float32]|Complex[float64]
# type Scalar* = float32|float64|Complex32|Complex64
type StdScalar* = float32|float64|StdComplex[float32]|StdComplex[float64]

proc newMatrixXd(x,y:int):MatrixXd {.importcpp:"Eigen::MatrixXd(@)", header:"<Eigen/Core>".}
proc newMatrixXf(x,y:int):MatrixXf {.importcpp:"Eigen::MatrixXf(@)", header:"<Eigen/Core>".}
proc newMatrixXcf(x,y:int):MatrixXcf {.importcpp:"Eigen::MatrixXcf(@)", header:"<Eigen/Core>".}
proc newMatrixXcd(x,y:int):MatrixXcd {.importcpp:"Eigen::MatrixXcd(@)", header:"<Eigen/Core>".}

proc matrix*(x,y:int,dtype:typedesc=Complex[float64]):MatrixType=
  when dtype is float64 or dtype is MatrixXd:
    result = newMatrixXd(x,y)
  elif dtype is float32 or dtype is MatrixXf:
    result = newMatrixXf(x,y)
  elif dtype is Complex[float32] or dtype is MatrixXcf:
    result = newMatrixXcf(x,y)
  elif dtype is Complex[float64] or dtype is MatrixXcd:
    result = newMatrixXcd(x,y)

proc matrix*(xy:tuple[rows,cols:int],dtype:typedesc=Complex[float64]):MatrixType=
  let
    x = xy.rows
    y = xy.cols
  when dtype is float64 or dtype is MatrixXd:
    result = newMatrixXd(x,y)
  elif dtype is float32 or dtype is MatrixXf:
    result = newMatrixXf(x,y)
  elif dtype is Complex[float32] or dtype is MatrixXcf:
    result = newMatrixXcf(x,y)
  elif dtype is Complex[float64] or dtype is MatrixXcd:
    result = newMatrixXcd(x,y)

proc destroyMatrix*(this: var MatrixType) {.importcpp: "#.Matrix::~Matrix()", header:"<Eigen/Core>".}
# proc `=destroy`*(this: var MatrixType)=destroyMatrix(this)

proc `[]`*(m:MatrixXd, row,col:int):float64 {.importcpp:"#(#,#)", header:"<Eigen/Core>".}
proc `[]`*(m:MatrixXf, row,col:int):float32 {.importcpp:"#(#,#)", header:"<Eigen/Core>".}
proc get(m:MatrixXcf, row,col:int):StdComplex[float32] {.importcpp:"#(#,#)", header:"<Eigen/Core>".}
proc `[]`*(m:MatrixXcf, row,col:int):Complex[float32]= m.get(row,col).toComplex()
proc get(m:MatrixXcd, row,col:int):StdComplex[float64] {.importcpp:"#(#,#)", header:"<Eigen/Core>".}
proc `[]`*(m:MatrixXcd, row,col:int):Complex[float64]= m.get(row,col).toComplex()

proc `[]=`*(m:var MatrixXd, row,col:int, v:float64) {.importcpp:"#(#,#)=#", header:"<Eigen/Core>".}
proc `[]=`*(m:var MatrixXf, row,col:int, v:float32) {.importcpp:"#(#,#)=#", header:"<Eigen/Core>".}
proc set(m:var MatrixXcf, row,col:int, v:StdComplex[float32]) {.importcpp:"#(#,#)=#", header:"<Eigen/Core>".}
proc `[]=`*(m:var MatrixXcf, row,col:int, v:Complex[float32])= m.set(row,col,v.toStdComplex())
proc set(m:var MatrixXcd, row,col:int, v:StdComplex[float64]) {.importcpp:"#(#,#)=#", header:"<Eigen/Core>".}
proc `[]=`*(m:var MatrixXcd, row,col:int, v:Complex[float64])= m.set(row,col, v.toStdComplex())

# template todtype(matrix_type:typedesc):type=
#   when dtype is float64 or dtype is MatrixXd:
#     result = float64
#   elif dtype is float32 or dtype is MatrixXf:
#     result = float32
#   elif dtype is Complex[float32] or dtype is MatrixXcf:
#     result = Complex[float32]
#   elif dtype is Complex[float64] or dtype is MatrixXcd:
#     result = Complex[float64]

template arrayToMatrix_inner(dtype:typedesc):untyped=
  var m = matrix(len(a),len(a[0]),dtype)
  for i,ai in a:
    for j,n in ai:
      m[i,j] = dtype(n)
    result = m

proc arrayToMatrix[T;row,col:static int](a:array[row,array[col,T]],dtype:typedesc=Complex[float64]):MatrixType=
  when dtype is float64 or dtype is MatrixXd:
    arrayToMatrix_inner(float64)
  elif dtype is float32 or dtype is MatrixXf:
    arrayToMatrix_inner(float32)
  elif dtype is Complex[float32] or dtype is MatrixXcf:
    arrayToMatrix_inner(Complex[float32])
  elif dtype is Complex[float64] or dtype is MatrixXcd:
    arrayToMatrix_inner(Complex[float64])

proc matrix*[T;row,col:static int](a:array[row,array[col,T]],dtype:typedesc=Complex[float64]):MatrixType=arrayToMatrix(a,dtype)

template seqToMatrix_inner(dtype:typedesc):untyped=
  var m = matrix(len(s), len(s[0]), dtype)
  for i,si in s:
    for j,n in si:
      m[i,j] = dtype(n)
  result = m


proc seqToMatrix[T](s:seq[seq[T]],dtype=Complex[float64]):MatrixType=
  when dtype is float64 or dtype is MatrixXd:
    seqToMatrix_inner(float64)
  elif dtype is float32 or dtype is MatrixXf:
    seqToMatrix_inner(float32)
  elif dtype is Complex[float32] or dtype is MatrixXcf:
    seqToMatrix_inner(Complex[float32])
  elif dtype is Complex[float64] or dtype is MatrixXcd:
    seqToMatrix_inner(Complex[float64])

proc matrix*[T](a:seq[seq[T]],dtype:typedesc=Complex[float64]):MatrixType=seqToMatrix(a,dtype)

proc toSeq*(this:MatrixType, dtype:typedesc=Complex[float64]):seq[seq[dtype]]=
  var res:seq[seq[dtype]] = @[]
  for i in 0..<this.rows():
    var res_line:seq[dtype] = @[]
    for j in 0..<this.cols():
      res_line.add(this[i,j].dtype)
    res.add(res_line)
  return res

proc real*(this:MatrixXcd):MatrixXd {.importcpp:"#.real()", header:"<Eigen/Core>".}
proc real*(this:MatrixXcf):MatrixXf {.importcpp:"#.real()", header:"<Eigen/Core>".}
proc imag*(this:MatrixXcd):MatrixXd {.importcpp:"#.imag()", header:"<Eigen/Core>".}
proc imag*(this:MatrixXcf):MatrixXf {.importcpp:"#.imag()", header:"<Eigen/Core>".}


proc size*(this:MatrixType):int {.importcpp:"#.size()", header:"<Eigen/Core>".}
proc rows*(this:MatrixType):int {.importcpp:"#.rows()", header:"<Eigen/Core>".}
proc cols*(this:MatrixType):int {.importcpp:"#.cols()", header:"<Eigen/Core>".}
proc shape*(this:MatrixType):tuple[rows:int, cols:int]=(this.rows(),this.cols())

proc `$`*(m:MatrixType):string=
  var s = ""
  for i in 0..<m.rows():
    s = s & "|\t"
    for j in 0..<m.cols():
      s = s & $m[i,j] & "\t"
    s = s & "|\n"

  result = s
  return


proc p_fill(m: var MatrixType, x:StdScalar){.importcpp:"#.fill(@)", header:"<Eigen/Core>".}
proc fill*(m: var MatrixType, x:Scalar)=
  m.p_fill(x.toStdNumber())


proc eyeXd(rows, cols:int):MatrixXd {.importcpp:"Eigen::MatrixXd::Identity(@)", header:"<Eigen/Core>".}
proc eyeXf(rows, cols:int):MatrixXf {.importcpp:"Eigen::MatrixXf::Identity(@)", header:"<Eigen/Core>".}
proc eyeXcf(rows, cols:int):MatrixXcf {.importcpp:"Eigen::MatrixXcf::Identity(@)", header:"<Eigen/Core>".}
proc eyeXcd(rows, cols:int):MatrixXcd {.importcpp:"Eigen::MatrixXcd::Identity(@)", header:"<Eigen/Core>".}

proc eye*(rows, cols:int,dtype:typedesc=Complex[float64]):MatrixType=
  when dtype is float64:
    result = eyeXd(rows, cols)
  elif dtype is float32:
    result = eyeXf(rows, cols)
  elif dtype is Complex[float32]:
    result = eyeXcf(rows, cols)
  elif dtype is Complex[float64]:
    result = eyeXcd(rows, cols)

proc eye*(rows:int, dtype:typedesc=Complex[float64]):MatrixType=
  return eye(rows, rows, dtype)

proc zerosXd(rows, cols:int):MatrixXd {.importcpp:"Eigen::MatrixXd::Zero(@)", header:"<Eigen/Core>".}
proc zerosXf(rows, cols:int):MatrixXf {.importcpp:"Eigen::MatrixXf::Zero(@)", header:"<Eigen/Core>".}
proc zerosXcf(rows, cols:int):MatrixXcf {.importcpp:"Eigen::MatrixXcf::Zero(@)", header:"<Eigen/Core>".}
proc zerosXcd(rows, cols:int):MatrixXcd {.importcpp:"Eigen::MatrixXcd::Zero(@)", header:"<Eigen/Core>".}

proc zeros*(rows, cols:int,dtype:typedesc=Complex[float64]):MatrixType=
  when dtype is float64:
    result = zerosXd(rows, cols)
  elif dtype is float32:
    result = zerosXf(rows, cols)
  elif dtype is Complex[float32]:
    result = zerosXcf(rows, cols)
  elif dtype is Complex[float64]:
    result = zerosXcd(rows, cols)

proc zeros*(rows:int,dtype:typedesc=Complex[float64]):MatrixType=zeros(rows, rows, dtype)

proc onesXd(rows, cols:int):MatrixXd {.importcpp:"Eigen::MatrixXd::Ones(@)", header:"<Eigen/Core>".}
proc onesXf(rows, cols:int):MatrixXf {.importcpp:"Eigen::MatrixXf::Ones(@)", header:"<Eigen/Core>".}
proc onesXcf(rows, cols:int):MatrixXcf {.importcpp:"Eigen::MatrixXcf::Ones(@)", header:"<Eigen/Core>".}
proc onesXcd(rows, cols:int):MatrixXcd {.importcpp:"Eigen::MatrixXcd::Ones(@)", header:"<Eigen/Core>".}

proc ones*(rows, cols:int,dtype:typedesc=Complex[float64]):MatrixType=
  when dtype is float64:
    result = onesXd(rows, cols)
  elif dtype is float32:
    result = onesXf(rows, cols)
  elif dtype is Complex[float32]:
    result = onesXcf(rows, cols)
  elif dtype is Complex[float64]:
    result = onesXcd(rows, cols)

proc ones*(rows:int, dtype:typedesc=Complex[float64]):MatrixType=ones(rows, rows, dtype)


proc randXd(rows, cols:int):MatrixXd {.importcpp:"Eigen::MatrixXd::Random(@)", header:"<Eigen/Core>".}
proc randXf(rows, cols:int):MatrixXf {.importcpp:"Eigen::MatrixXf::Random(@)", header:"<Eigen/Core>".}
proc randXcf(rows, cols:int):MatrixXcf {.importcpp:"Eigen::MatrixXcf::Random(@)", header:"<Eigen/Core>".}
proc randXcd(rows, cols:int):MatrixXcd {.importcpp:"Eigen::MatrixXcd::Random(@)", header:"<Eigen/Core>".}

proc rand*(rows, cols:int,dtype:typedesc=Complex[float64]):MatrixType=
  when dtype is float64:
    result = randXd(rows, cols)
  elif dtype is float32:
    result = randXf(rows, cols)
  elif dtype is Complex[float32]:
    result = randXcf(rows, cols)
  elif dtype is Complex[float64]:
    result = randXcd(rows, cols)

proc rand*(rows:int,dtype:typedesc=Complex[float64]):MatrixType=rand(rows, rows, dtype)


proc linspaceXd(size:int, low_number, high_number:float64):MatrixXd {.importcpp:"Eigen::ArrayXd::LinSpaced(@).matrix()", header:"<Eigen/Core>".}
proc linspaceXf(size:int, low_number, high_number:float64):MatrixXf {.importcpp:"Eigen::ArrayXf::LinSpaced(@).matrix()", header:"<Eigen/Core>".}

proc linspace*(low_number, high_number:float64, size:int, dtype:typedesc=float64):MatrixType=
  when dtype is float64:
    result = linspaceXd(size, low_number, high_number)
  elif dtype is float32:
    result = linspaceXf(size, low_number, high_number)


proc full*[T:Scalar](rows,cols:int, fill_number:T):MatrixType=
  var res = matrix(rows,cols,type(fill_number))
  res.fill(fill_number)
  return res

proc astype_2d(this:MatrixType):MatrixXd {.importcpp:"#.cast<double>()", header:"<Eigen/Core>".}
proc astype_2f(this:MatrixType):MatrixXf {.importcpp:"#.cast<float>()", header:"<Eigen/Core>".}
proc astype_2cd(this:MatrixType):MatrixXcd {.importcpp:"#.cast<std::complex<double>>()", header:"<Eigen/Core>".}
proc astype_2cf(this:MatrixType):MatrixXcf {.importcpp:"#.cast<std::complex<float>>()", header:"<Eigen/Core>".}

converter toMatrixXd*(x:MatrixXf):MatrixXd=astype_2d(x)
converter toMatrixXcf*(x:MatrixXf):MatrixXcf=astype_2cf(x)
converter toMatrixXcd*(x:MatrixXf):MatrixXcd=astype_2cd(x)
converter toMatrixXcf*(x:MatrixXd):MatrixXcf=astype_2cf(x)
converter toMatrixXcd*(x:MatrixXd):MatrixXcd=astype_2cd(x)
converter toMatrixXcd*(x:MatrixXcf):MatrixXcd=astype_2cd(x)
