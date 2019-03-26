# this file contains all operators + - * / .+ .- .* ./ .^
import complex except Complex32, Complex64
import ./matrix

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

