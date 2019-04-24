# this file contains all operators + - * /
import complex except Complex32, Complex64
import ./matrix
import ./sparsematrix
include ./eigentype

proc `+`*(x,y: SparseMatrixXdC):SparseMatrixXdC {.importcpp:"# + #", header:"<Eigen/SparseCore>".}
proc `+`*(x,y: SparseMatrixXfC):SparseMatrixXfC {.importcpp:"# + #", header:"<Eigen/SparseCore>".}
proc `+`*(x,y: SparseMatrixXcdC):SparseMatrixXcdC {.importcpp:"# + #", header:"<Eigen/SparseCore>".}
proc `+`*(x,y: SparseMatrixXcfC):SparseMatrixXcfC {.importcpp:"# + #", header:"<Eigen/SparseCore>".}
proc `+`*(x,y: SparseMatrixXdR):SparseMatrixXdR {.importcpp:"# + #", header:"<Eigen/SparseCore>".}
proc `+`*(x,y: SparseMatrixXfR):SparseMatrixXfR {.importcpp:"# + #", header:"<Eigen/SparseCore>".}
proc `+`*(x,y: SparseMatrixXcdR):SparseMatrixXcdR {.importcpp:"# + #", header:"<Eigen/SparseCore>".}
proc `+`*(x,y: SparseMatrixXcfR):SparseMatrixXcfR {.importcpp:"# + #", header:"<Eigen/SparseCore>".}

proc `-`*(x,y: SparseMatrixXdC):SparseMatrixXdC {.importcpp:"# - #", header:"<Eigen/SparseCore>".}
proc `-`*(x,y: SparseMatrixXfC):SparseMatrixXfC {.importcpp:"# - #", header:"<Eigen/SparseCore>".}
proc `-`*(x,y: SparseMatrixXcdC):SparseMatrixXcdC {.importcpp:"# - #", header:"<Eigen/SparseCore>".}
proc `-`*(x,y: SparseMatrixXcfC):SparseMatrixXcfC {.importcpp:"# - #", header:"<Eigen/SparseCore>".}
proc `-`*(x,y: SparseMatrixXdR):SparseMatrixXdR {.importcpp:"# - #", header:"<Eigen/SparseCore>".}
proc `-`*(x,y: SparseMatrixXfR):SparseMatrixXfR {.importcpp:"# - #", header:"<Eigen/SparseCore>".}
proc `-`*(x,y: SparseMatrixXcdR):SparseMatrixXcdR {.importcpp:"# - #", header:"<Eigen/SparseCore>".}
proc `-`*(x,y: SparseMatrixXcfR):SparseMatrixXcfR {.importcpp:"# - #", header:"<Eigen/SparseCore>".}

proc `*`*(x,y: SparseMatrixXdC):SparseMatrixXdC {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x,y: SparseMatrixXfC):SparseMatrixXfC {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x,y: SparseMatrixXcdC):SparseMatrixXcdC {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x,y: SparseMatrixXcfC):SparseMatrixXcfC {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x,y: SparseMatrixXdR):SparseMatrixXdR {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x,y: SparseMatrixXfR):SparseMatrixXfR {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x,y: SparseMatrixXcdR):SparseMatrixXcdR {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x,y: SparseMatrixXcfR):SparseMatrixXcfR {.importcpp:"# * #", header:"<Eigen/SparseCore>".}

proc `*`*(x:float64, y: SparseMatrixXdC):SparseMatrixXdC {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x:float32, y: SparseMatrixXfC):SparseMatrixXfC {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x:StdComplex[float64], y: SparseMatrixXcdC):SparseMatrixXcdC {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x:StdComplex[float32], y: SparseMatrixXcfC):SparseMatrixXcfC {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x:Complex[float64], y: SparseMatrixXcdC):SparseMatrixXcdC= x.toStdComplex() * y
proc `*`*(x:Complex[float32], y: SparseMatrixXcfC):SparseMatrixXcfC= x.toStdComplex() * y
proc `*`*(x:float64, y: SparseMatrixXdR):SparseMatrixXdR {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x:float32, y: SparseMatrixXfR):SparseMatrixXfR {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x:StdComplex[float64], y: SparseMatrixXcdR):SparseMatrixXcdR {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x:StdComplex[float32], y: SparseMatrixXcfR):SparseMatrixXcfR {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x:Complex[float64], y: SparseMatrixXcdR):SparseMatrixXcdR= x.toStdComplex() * y
proc `*`*(x:Complex[float32], y: SparseMatrixXcfR):SparseMatrixXcfR= x.toStdComplex() * y

proc `*`*(x: SparseMatrixXdC, y:float64):SparseMatrixXdC {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x: SparseMatrixXfC, y:float32):SparseMatrixXfC {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x: SparseMatrixXcdC, y:StdComplex[float64]):SparseMatrixXcdC {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x: SparseMatrixXcfC, y:StdComplex[float32]):SparseMatrixXcfC {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x: SparseMatrixXcdC, y:Complex[float64]):SparseMatrixXcdC= x * y.toStdComplex()
proc `*`*(x: SparseMatrixXcfC, y:Complex[float32]):SparseMatrixXcfC= x * y.toStdComplex()

proc `*`*(x: SparseMatrixXdR, y:float64):SparseMatrixXdR {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x: SparseMatrixXfR, y:float32):SparseMatrixXfR {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x: SparseMatrixXcdR, y:StdComplex[float64]):SparseMatrixXcdR {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x: SparseMatrixXcfR, y:StdComplex[float32]):SparseMatrixXcfR {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x: SparseMatrixXcdR, y:Complex[float64]):SparseMatrixXcdR= x * y.toStdComplex()
proc `*`*(x: SparseMatrixXcfR, y:Complex[float32]):SparseMatrixXcfR= x * y.toStdComplex()

proc `*`*(x: SparseMatrixXdR, y:MatrixXd):MatrixXd {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x: SparseMatrixXfR, y:MatrixXf):MatrixXf {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x: SparseMatrixXcdR, y:MatrixXcd):MatrixXcd {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x: SparseMatrixXcfR, y:MatrixXcf):MatrixXcf {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x: SparseMatrixXdC, y:MatrixXd):MatrixXd {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x: SparseMatrixXfC, y:MatrixXf):MatrixXf {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x: SparseMatrixXcdC, y:MatrixXcd):MatrixXcd {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x: SparseMatrixXcfC, y:MatrixXcf):MatrixXcf {.importcpp:"# * #", header:"<Eigen/SparseCore>".}

proc `*`*(x:MatrixXd, y: SparseMatrixXdR):MatrixXd {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x:MatrixXf, y: SparseMatrixXfR):MatrixXf {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x:MatrixXcd, y: SparseMatrixXcdR):MatrixXcd {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x:MatrixXcf, y: SparseMatrixXcfR):MatrixXcf {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x:MatrixXd, y: SparseMatrixXdC):MatrixXd {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x:MatrixXf, y: SparseMatrixXfC):MatrixXf {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x:MatrixXcd, y: SparseMatrixXcdC):MatrixXcd {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `*`*(x:MatrixXcf, y: SparseMatrixXcfC):MatrixXcf {.importcpp:"# * #", header:"<Eigen/SparseCore>".}

proc `/`*(x: SparseMatrixXdC, y:float64):SparseMatrixXdC {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `/`*(x: SparseMatrixXfC, y:float32):SparseMatrixXfC {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `/`*(x: SparseMatrixXcdC, y:StdComplex[float64]):SparseMatrixXcdC {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `/`*(x: SparseMatrixXcfC, y:StdComplex[float32]):SparseMatrixXcfC {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `/`*(x: SparseMatrixXcdC, y:Complex[float64]):SparseMatrixXcdC= x / y.toStdComplex()
proc `/`*(x: SparseMatrixXcfC, y:Complex[float32]):SparseMatrixXcfC= x / y.toStdComplex()

proc `/`*(x: SparseMatrixXdR, y:float64):SparseMatrixXdR {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `/`*(x: SparseMatrixXfR, y:float32):SparseMatrixXfR {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `/`*(x: SparseMatrixXcdR, y:StdComplex[float64]):SparseMatrixXcdR {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `/`*(x: SparseMatrixXcfR, y:StdComplex[float32]):SparseMatrixXcfR {.importcpp:"# * #", header:"<Eigen/SparseCore>".}
proc `/`*(x: SparseMatrixXcdR, y:Complex[float64]):SparseMatrixXcdR= x / y.toStdComplex()
proc `/`*(x: SparseMatrixXcfR, y:Complex[float32]):SparseMatrixXcfR= x / y.toStdComplex()



