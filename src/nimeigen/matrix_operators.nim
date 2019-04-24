# this file contains all operators + - * / .+ .- .* ./ .^
import complex
import ./matrix

template do_for_all_ms(matrix_type,scalar_type:typedesc)=
  proc `+`*(x:matrix_type, y:scalar_type):matrix_type=
    result = x
    for i in 0..<x.rows():
      for j in 0..<x.cols():
        result[i,j] = x[i,j] + y
  proc `+`*(x:scalar_type, y:matrix_type):matrix_type=
    result = y
    for i in 0..<y.rows():
      for j in 0..<y.cols():
        result[i,j] = y[i,j] + x

  proc `-`*(x:matrix_type, y:scalar_type):matrix_type=
    result = x
    for i in 0..<x.rows():
      for j in 0..<x.cols():
        result[i,j] = x[i,j] - y
  proc `-`*(x:scalar_type, y:matrix_type):matrix_type=
    result = y
    for i in 0..<y.rows():
      for j in 0..<y.cols():
        result[i,j] = x - y[i,j]

do_for_all_ms(MatrixXcd, Complex[float64])
do_for_all_ms(MatrixXcf, Complex[float32])
do_for_all_ms(MatrixXd, float64)
do_for_all_ms(MatrixXf, float32)

proc `.*`*[T:MatrixType](x,y:T):T=
  if (x.rows()!=y.rows()) or (x.cols()!=y.cols()):
    raise newException(ValueError, "matrix are not same")
  result = x
  for i in 0..<x.rows():
    for j in 0..<x.cols():
      result[i,j] = x[i,j] * y[i,j]

proc `./`*[T:MatrixType](x,y:T):T=
  if (x.rows()!=y.rows()) or (x.cols()!=y.cols()):
    raise newException(ValueError, "matrix are not same")
  result = x
  for i in 0..<x.rows():
    for j in 0..<x.cols():
      result[i,j] = x[i,j] / y[i,j]


proc `+`*(x,y: MatrixXd):MatrixXd {.importcpp:"# + #", header:"<Eigen/Core>".}
proc `+`*(x,y: MatrixXf):MatrixXf {.importcpp:"# + #", header:"<Eigen/Core>".}
proc `+`*(x,y: MatrixXcd):MatrixXcd {.importcpp:"# + #", header:"<Eigen/Core>".}
proc `+`*(x,y: MatrixXcf):MatrixXcf {.importcpp:"# + #", header:"<Eigen/Core>".}

proc `-`*(x,y: MatrixXd):MatrixXd {.importcpp:"# - #", header:"<Eigen/Core>".}
proc `-`*(x,y: MatrixXf):MatrixXf {.importcpp:"# - #", header:"<Eigen/Core>".}
proc `-`*(x,y: MatrixXcd):MatrixXcd {.importcpp:"# - #", header:"<Eigen/Core>".}
proc `-`*(x,y: MatrixXcf):MatrixXcf {.importcpp:"# - #", header:"<Eigen/Core>".}

proc `*`*(x,y: MatrixXd):MatrixXd {.importcpp:"# * #", header:"<Eigen/Core>".}
proc `*`*(x,y: MatrixXf):MatrixXf {.importcpp:"# * #", header:"<Eigen/Core>".}
proc `*`*(x,y: MatrixXcd):MatrixXcd {.importcpp:"# * #", header:"<Eigen/Core>".}
proc `*`*(x,y: MatrixXcf):MatrixXcf {.importcpp:"# * #", header:"<Eigen/Core>".}

proc `*`*(x:float64, y: MatrixXd):MatrixXd {.importcpp:"# * #", header:"<Eigen/Core>".}
proc `*`*(x:float32, y: MatrixXf):MatrixXf {.importcpp:"# * #", header:"<Eigen/Core>".}
proc `*`*(x:StdComplex[float64], y: MatrixXcd):MatrixXcd {.importcpp:"# * #", header:"<Eigen/Core>".}
proc `*`*(x:StdComplex[float32], y: MatrixXcf):MatrixXcf {.importcpp:"# * #", header:"<Eigen/Core>".}
proc `*`*(x:Complex[float64], y: MatrixXcd):MatrixXcd= x.toStdComplex() * y
proc `*`*(x:Complex[float32], y: MatrixXcf):MatrixXcf= x.toStdComplex() * y

proc `*`*(x: MatrixXd, y:float64):MatrixXd {.importcpp:"# * #", header:"<Eigen/Core>".}
proc `*`*(x: MatrixXf, y:float32):MatrixXf {.importcpp:"# * #", header:"<Eigen/Core>".}
proc `*`*(x: MatrixXcd, y:StdComplex[float64]):MatrixXcd {.importcpp:"# * #", header:"<Eigen/Core>".}
proc `*`*(x: MatrixXcf, y:StdComplex[float32]):MatrixXcf {.importcpp:"# * #", header:"<Eigen/Core>".}
proc `*`*(x: MatrixXcd, y:Complex[float64]):MatrixXcd= x * y.toStdComplex()
proc `*`*(x: MatrixXcf, y:Complex[float32]):MatrixXcf= x * y.toStdComplex()

proc `/`*(x: MatrixXd, y:float64):MatrixXd {.importcpp:"# * #", header:"<Eigen/Core>".}
proc `/`*(x: MatrixXf, y:float32):MatrixXf {.importcpp:"# * #", header:"<Eigen/Core>".}
proc `/`*(x: MatrixXcd, y:StdComplex[float64]):MatrixXcd {.importcpp:"# * #", header:"<Eigen/Core>".}
proc `/`*(x: MatrixXcf, y:StdComplex[float32]):MatrixXcf {.importcpp:"# * #", header:"<Eigen/Core>".}
proc `/`*(x: MatrixXcd, y:Complex[float64]):MatrixXcd= x / y.toStdComplex()
proc `/`*(x: MatrixXcf, y:Complex[float32]):MatrixXcf= x / y.toStdComplex()



proc `.*`*(x:float64, y: MatrixXd):MatrixXd {.importcpp:"(# * #.array()).matrix()", header:"<Eigen/Core>".}
proc `.*`*(x:float32, y: MatrixXf):MatrixXf {.importcpp:"(# * #.array()).matrix()", header:"<Eigen/Core>".}
proc `.*`*(x:StdComplex[float64], y: MatrixXcd):MatrixXcd {.importcpp:"(# * #.array()).matrix()", header:"<Eigen/Core>".}
proc `.*`*(x:StdComplex[float32], y: MatrixXcf):MatrixXcf {.importcpp:"(# * #.array()).matrix()", header:"<Eigen/Core>".}
proc `.*`*(x:Complex[float64], y: MatrixXcd):MatrixXcd= x.toStdComplex() .* y
proc `.*`*(x:Complex[float32], y: MatrixXcf):MatrixXcf= x.toStdComplex() .* y

proc `.*`*(x: MatrixXd, y:float64):MatrixXd {.importcpp:"(#.array() * #).matrix()", header:"<Eigen/Core>".}
proc `.*`*(x: MatrixXf, y:float32):MatrixXf {.importcpp:"(#.array() * #).matrix()", header:"<Eigen/Core>".}
proc `.*`*(x: MatrixXcd, y:StdComplex[float64]):MatrixXcd {.importcpp:"(#.array() * #).matrix()", header:"<Eigen/Core>".}
proc `.*`*(x: MatrixXcf, y:StdComplex[float32]):MatrixXcf {.importcpp:"(#.array() * #).matrix()", header:"<Eigen/Core>".}
proc `.*`*(x: MatrixXcd, y:Complex[float64]):MatrixXcd= x .* y.toStdComplex()
proc `.*`*(x: MatrixXcf, y:Complex[float32]):MatrixXcf= x .* y.toStdComplex()


proc `./`*(x:float64, y: MatrixXd):MatrixXd {.importcpp:"(# / #.array()).matrix()", header:"<Eigen/Core>".}
proc `./`*(x:float32, y: MatrixXf):MatrixXf {.importcpp:"(# / #.array()).matrix()", header:"<Eigen/Core>".}
proc `./`*(x:StdComplex[float64], y: MatrixXcd):MatrixXcd {.importcpp:"(# / #.array()).matrix()", header:"<Eigen/Core>".}
proc `./`*(x:StdComplex[float32], y: MatrixXcf):MatrixXcf {.importcpp:"(# / #.array()).matrix()", header:"<Eigen/Core>".}
proc `./`*(x:Complex[float64], y: MatrixXcd):MatrixXcd= x.toStdComplex() ./ y
proc `./`*(x:Complex[float32], y: MatrixXcf):MatrixXcf= x.toStdComplex() ./ y

proc `./`*(x: MatrixXd, y:float64):MatrixXd {.importcpp:"(#.array() / #).matrix()", header:"<Eigen/Core>".}
proc `./`*(x: MatrixXf, y:float32):MatrixXf {.importcpp:"(#.array() / #).matrix()", header:"<Eigen/Core>".}
proc `./`*(x: MatrixXcd, y:StdComplex[float64]):MatrixXcd {.importcpp:"(#.array() / #).matrix()", header:"<Eigen/Core>".}
proc `./`*(x: MatrixXcf, y:StdComplex[float32]):MatrixXcf {.importcpp:"(#.array() / #).matrix()", header:"<Eigen/Core>".}
proc `./`*(x: MatrixXcd, y:Complex[float64]):MatrixXcd= x ./ y.toStdComplex()
proc `./`*(x: MatrixXcf, y:Complex[float32]):MatrixXcf= x ./ y.toStdComplex()



proc `.+`*(x:float64, y: MatrixXd):MatrixXd {.importcpp:"(# + #.array()).matrix()", header:"<Eigen/Core>".}
proc `.+`*(x:float32, y: MatrixXf):MatrixXf {.importcpp:"(# + #.array()).matrix()", header:"<Eigen/Core>".}
proc `.+`*(x:StdComplex[float64], y: MatrixXcd):MatrixXcd {.importcpp:"(# + #.array()).matrix()", header:"<Eigen/Core>".}
proc `.+`*(x:StdComplex[float32], y: MatrixXcf):MatrixXcf {.importcpp:"(# + #.array()).matrix()", header:"<Eigen/Core>".}
proc `.+`*(x:Complex[float64], y: MatrixXcd):MatrixXcd= x.toStdComplex() .+ y
proc `.+`*(x:Complex[float32], y: MatrixXcf):MatrixXcf= x.toStdComplex() .+ y

proc `.+`*(x: MatrixXd, y:float64):MatrixXd {.importcpp:"(#.array() + #).matrix()", header:"<Eigen/Core>".}
proc `.+`*(x: MatrixXf, y:float32):MatrixXf {.importcpp:"(#.array() + #).matrix()", header:"<Eigen/Core>".}
proc `.+`*(x: MatrixXcd, y:StdComplex[float64]):MatrixXcd {.importcpp:"(#.array() + #).matrix()", header:"<Eigen/Core>".}
proc `.+`*(x: MatrixXcf, y:StdComplex[float32]):MatrixXcf {.importcpp:"(#.array() + #).matrix()", header:"<Eigen/Core>".}
proc `.+`*(x: MatrixXcd, y:Complex[float64]):MatrixXcd= x .+ y.toStdComplex()
proc `.+`*(x: MatrixXcf, y:Complex[float32]):MatrixXcf= x .+ y.toStdComplex()

proc `.-`*(x:float64, y: MatrixXd):MatrixXd {.importcpp:"(# - #.array()).matrix()", header:"<Eigen/Core>".}
proc `.-`*(x:float32, y: MatrixXf):MatrixXf {.importcpp:"(# - #.array()).matrix()", header:"<Eigen/Core>".}
proc `.-`*(x:StdComplex[float64], y: MatrixXcd):MatrixXcd {.importcpp:"(# - #.array()).matrix()", header:"<Eigen/Core>".}
proc `.-`*(x:StdComplex[float32], y: MatrixXcf):MatrixXcf {.importcpp:"(# - #.array()).matrix()", header:"<Eigen/Core>".}
proc `.-`*(x:Complex[float64], y: MatrixXcd):MatrixXcd= x.toStdComplex() .- y
proc `.-`*(x:Complex[float32], y: MatrixXcf):MatrixXcf= x.toStdComplex() .- y

proc `.-`*(x: MatrixXd, y:float64):MatrixXd {.importcpp:"(#.array() - #).matrix()", header:"<Eigen/Core>".}
proc `.-`*(x: MatrixXf, y:float32):MatrixXf {.importcpp:"(#.array() - #).matrix()", header:"<Eigen/Core>".}
proc `.-`*(x: MatrixXcd, y:StdComplex[float64]):MatrixXcd {.importcpp:"(#.array() - #).matrix()", header:"<Eigen/Core>".}
proc `.-`*(x: MatrixXcf, y:StdComplex[float32]):MatrixXcf {.importcpp:"(#.array() - #).matrix()", header:"<Eigen/Core>".}
proc `.-`*(x: MatrixXcd, y:Complex[float64]):MatrixXcd= x .- y.toStdComplex()
proc `.-`*(x: MatrixXcf, y:Complex[float32]):MatrixXcf= x .- y.toStdComplex()

proc `.^`*(x: MatrixXd, y:float64):MatrixXd {.importcpp:"(#.array().pow(#)).matrix()", header:"<Eigen/Core>".}
proc `.^`*(x: MatrixXf, y:float32):MatrixXf {.importcpp:"(#.array().pow(#)).matrix()", header:"<Eigen/Core>".}
proc `.^`*(x: MatrixXcd, y:StdComplex[float64]):MatrixXcd {.importcpp:"(#.array().pow(#)).matrix()", header:"<Eigen/Core>".}
proc `.^`*(x: MatrixXcf, y:StdComplex[float32]):MatrixXcf {.importcpp:"(#.array().pow(#)).matrix()", header:"<Eigen/Core>".}
proc `.^`*(x: MatrixXcd, y:Complex[float64]):MatrixXcd= x .^ y.toStdComplex()
proc `.^`*(x: MatrixXcf, y:Complex[float32]):MatrixXcf= x .^ y.toStdComplex()

