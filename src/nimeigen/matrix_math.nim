# This file contains math functions
# 1. transpose, trans, conjugate, conj, adjoint
# 2. sum, prod, mean, min, max
# 3. trace
# 4. abs, sin, cos, sqrt, exp, log
# 5. norm, diag, eigenvalues
import complex except Complex32, Complex64
import ./matrix, ./matrix_operators

proc transpose*[T:MatrixType](m:T):T {.importcpp:"#.transpose()", header:"<Eigen/Core>".}
proc trans*[T:MatrixType](m:T):T {.importcpp:"#.transpose()", header:"<Eigen/Core>".}
proc T*[T:MatrixType](m:T):T {.importcpp:"#.transpose()", header:"<Eigen/Core>".}
proc conjugate*[T:MatrixType](m:T):T {.importcpp:"#.conjugate()", header:"<Eigen/Core>".}
proc conj*[T:MatrixType](m:T):T {.importcpp:"#.conjugate()", header:"<Eigen/Core>".}
proc adjoint*[T:MatrixType](m:T):T {.importcpp:"#.adjoint()", header:"<Eigen/Core>".}
proc H*[T:MatrixType](m:T):T {.importcpp:"#.adjoint()", header:"<Eigen/Core>".}


proc abs*(m:MatrixXf):MatrixXf {.importcpp:"#.array().abs().matrix()", header:"<Eigen/Core>".}
proc abs*(m:MatrixXd):MatrixXd {.importcpp:"#.array().abs().matrix()", header:"<Eigen/Core>".}
proc abs*(m:MatrixXcf):MatrixXf {.importcpp:"#.array().abs().matrix()", header:"<Eigen/Core>".}
proc abs*(m:MatrixXcd):MatrixXd {.importcpp:"#.array().abs().matrix()", header:"<Eigen/Core>".}

proc sin*(m:MatrixXf):MatrixXf {.importcpp:"#.array().sin().matrix()", header:"<Eigen/Core>".}
proc sin*(m:MatrixXd):MatrixXd {.importcpp:"#.array().sin().matrix()", header:"<Eigen/Core>".}
proc sin*(m:MatrixXcf):MatrixXf {.importcpp:"#.array().sin().matrix()", header:"<Eigen/Core>".}
proc sin*(m:MatrixXcd):MatrixXd {.importcpp:"#.array().sin().matrix()", header:"<Eigen/Core>".}

proc cos*(m:MatrixXf):MatrixXf {.importcpp:"#.array().cos().matrix()", header:"<Eigen/Core>".}
proc cos*(m:MatrixXd):MatrixXd {.importcpp:"#.array().cos().matrix()", header:"<Eigen/Core>".}
proc cos*(m:MatrixXcf):MatrixXf {.importcpp:"#.array().cos().matrix()", header:"<Eigen/Core>".}
proc cos*(m:MatrixXcd):MatrixXd {.importcpp:"#.array().cos().matrix()", header:"<Eigen/Core>".}

proc sqrt*(m:MatrixXf):MatrixXf {.importcpp:"#.array().sqrt().matrix()", header:"<Eigen/Core>".}
proc sqrt*(m:MatrixXd):MatrixXd {.importcpp:"#.array().sqrt().matrix()", header:"<Eigen/Core>".}
proc sqrt*(m:MatrixXcf):MatrixXf {.importcpp:"#.array().sqrt().matrix()", header:"<Eigen/Core>".}
proc sqrt*(m:MatrixXcd):MatrixXd {.importcpp:"#.array().sqrt().matrix()", header:"<Eigen/Core>".}

proc exp*(m:MatrixXf):MatrixXf {.importcpp:"#.array().exp().matrix()", header:"<Eigen/Core>".}
proc exp*(m:MatrixXd):MatrixXd {.importcpp:"#.array().exp().matrix()", header:"<Eigen/Core>".}
proc exp*(m:MatrixXcf):MatrixXf {.importcpp:"#.array().exp().matrix()", header:"<Eigen/Core>".}
proc exp*(m:MatrixXcd):MatrixXd {.importcpp:"#.array().exp().matrix()", header:"<Eigen/Core>".}

proc log*(m:MatrixXf):MatrixXf {.importcpp:"#.array().log().matrix()", header:"<Eigen/Core>".}
proc log*(m:MatrixXd):MatrixXd {.importcpp:"#.array().log().matrix()", header:"<Eigen/Core>".}
proc log*(m:MatrixXcf):MatrixXf {.importcpp:"#.array().log().matrix()", header:"<Eigen/Core>".}
proc log*(m:MatrixXcd):MatrixXd {.importcpp:"#.array().log().matrix()", header:"<Eigen/Core>".}


proc sum*(m:MatrixXf):float32 {.importcpp:"#.sum()", header:"<Eigen/Core>".}
proc sum*(m:MatrixXd):float64 {.importcpp:"#.sum()", header:"<Eigen/Core>".}
proc sumStd(m:MatrixXcf):StdComplex[float32] {.importcpp:"#.sum()", header:"<Eigen/Core>".}
proc sumStd(m:MatrixXcd):StdComplex[float64] {.importcpp:"#.sum()", header:"<Eigen/Core>".}
proc sum*(m:MatrixXcf):Complex[float32]= m.sumStd().toComplex()
proc sum*(m:MatrixXcd):Complex[float64]= m.sumStd().toComplex()


proc prod*(m:MatrixXf):float32 {.importcpp:"#.prod()", header:"<Eigen/Core>".}
proc prod*(m:MatrixXd):float64 {.importcpp:"#.prod()", header:"<Eigen/Core>".}
proc prodStd(m:MatrixXcf):StdComplex[float32] {.importcpp:"#.prod()", header:"<Eigen/Core>".}
proc prodStd(m:MatrixXcd):StdComplex[float64] {.importcpp:"#.prod()", header:"<Eigen/Core>".}
proc prod*(m:MatrixXcf):Complex[float32]= m.prodStd().toComplex()
proc prod*(m:MatrixXcd):Complex[float64]= m.prodStd().toComplex()


proc mean*(m:MatrixXf):float32 {.importcpp:"#.mean()", header:"<Eigen/Core>".}
proc mean*(m:MatrixXd):float64 {.importcpp:"#.mean()", header:"<Eigen/Core>".}
proc meanStd(m:MatrixXcf):StdComplex[float32] {.importcpp:"#.mean()", header:"<Eigen/Core>".}
proc meanStd(m:MatrixXcd):StdComplex[float64] {.importcpp:"#.mean()", header:"<Eigen/Core>".}
proc mean*(m:MatrixXcf):Complex[float32]= m.meanStd().toComplex()
proc mean*(m:MatrixXcd):Complex[float64]= m.meanStd().toComplex()


proc minCoeff(m:MatrixXf):float32 {.importcpp:"#.minCoeff()", header:"<Eigen/Core>".}
proc minCoeff(m:MatrixXd):float64 {.importcpp:"#.minCoeff()", header:"<Eigen/Core>".}
proc min*(m:MatrixXf):float32 = m.minCoeff()
proc min*(m:MatrixXd):float64 = m.minCoeff()

proc maxCoeff(m:MatrixXf):float32 {.importcpp:"#.maxCoeff()", header:"<Eigen/Core>".}
proc maxCoeff(m:MatrixXd):float64 {.importcpp:"#.maxCoeff()", header:"<Eigen/Core>".}
proc max*(m:MatrixXf):float32 = m.maxCoeff()
proc max*(m:MatrixXd):float64 = m.maxCoeff()

proc trace*(m:MatrixXf):float32 {.importcpp:"#.trace()", header:"<Eigen/Core>".}
proc trace*(m:MatrixXd):float64 {.importcpp:"#.trace()", header:"<Eigen/Core>".}
proc traceStd(m:MatrixXcf):StdComplex[float32] {.importcpp:"#.trace()", header:"<Eigen/Core>".}
proc traceStd(m:MatrixXcd):StdComplex[float64] {.importcpp:"#.trace()", header:"<Eigen/Core>".}
proc trace*(m:MatrixXcf):Complex[float32]= m.traceStd().toComplex()
proc trace*(m:MatrixXcd):Complex[float64]= m.traceStd().toComplex()

proc diagonal*(m:MatrixXcd):MatrixXcd {.importcpp:"#.diagonal()", header:"<Eigen/Core>".}
proc diagonal*(m:MatrixXcf):MatrixXcf {.importcpp:"#.diagonal()", header:"<Eigen/Core>".}
proc diagonal*(m:MatrixXd):MatrixXd {.importcpp:"#.diagonal()", header:"<Eigen/Core>".}
proc diagonal*(m:MatrixXf):MatrixXf {.importcpp:"#.diagonal()", header:"<Eigen/Core>".}

proc diag*(m:MatrixXcd):MatrixXcd {.importcpp:"#.diagonal()", header:"<Eigen/Core>".}
proc diag*(m:MatrixXcf):MatrixXcf {.importcpp:"#.diagonal()", header:"<Eigen/Core>".}
proc diag*(m:MatrixXd):MatrixXd {.importcpp:"#.diagonal()", header:"<Eigen/Core>".}
proc diag*(m:MatrixXf):MatrixXf {.importcpp:"#.diagonal()", header:"<Eigen/Core>".}

proc norm*(m:MatrixXcd):float64 {.importcpp:"#.norm()", header:"<Eigen/Core>".}
proc norm*(m:MatrixXcf):float32 {.importcpp:"#.norm()", header:"<Eigen/Core>".}
proc norm*(m:MatrixXd):float64 {.importcpp:"#.norm()", header:"<Eigen/Core>".}
proc norm*(m:MatrixXf):float32 {.importcpp:"#.norm()", header:"<Eigen/Core>".}

proc eigenvalues*(m:MatrixXcd):MatrixXcd {.importcpp:"#.eigenvalues()", header:"<Eigen/Eigenvalues>".}
proc eigenvalues*(m:MatrixXcf):MatrixXcf {.importcpp:"#.eigenvalues()", header:"<Eigen/Eigenvalues>".}
proc eigenvalues*(m:MatrixXd):MatrixXcd {.importcpp:"#.eigenvalues()", header:"<Eigen/Eigenvalues>".}
proc eigenvalues*(m:MatrixXf):MatrixXcf {.importcpp:"#.eigenvalues()", header:"<Eigen/Eigenvalues>".}
