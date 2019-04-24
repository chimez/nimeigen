# this file includes
# 1. SparseMatrixType
# 2. convert from/to dense matrix, tocsc, tocsr
# 3. $
# 4. issparse, isspmatrix, isspmatrix_csr, isspmatrix_csc
# 5. get_shape


import ./matrix
include ./eigentype

type SparseMatrixXcdC* {.importcpp:"SparseMatrixXcdC", header:"<Eigen/SparseCore>".} = object
type SparseMatrixXcfC* {.importcpp:"SparseMatrixXcfC", header:"<Eigen/SparseCore>".} = object
type SparseMatrixXdC* {.importcpp:"SparseMatrixXdC", header:"<Eigen/SparseCore>".} = object
type SparseMatrixXfC* {.importcpp:"SparseMatrixXfC", header:"<Eigen/SparseCore>".} = object
type SparseMatrixXcdR* {.importcpp:"SparseMatrixXcdR", header:"<Eigen/SparseCore>".} = object
type SparseMatrixXcfR* {.importcpp:"SparseMatrixXcfR", header:"<Eigen/SparseCore>".} = object
type SparseMatrixXdR* {.importcpp:"SparseMatrixXdR", header:"<Eigen/SparseCore>".} = object
type SparseMatrixXfR* {.importcpp:"SparseMatrixXfR", header:"<Eigen/SparseCore>".} = object

type SparseMatrixCType* = SparseMatrixXfC|SparseMatrixXdC|SparseMatrixXcdC|SparseMatrixXcfC
type SparseMatrixRType* = SparseMatrixXfR|SparseMatrixXdR|SparseMatrixXcdR|SparseMatrixXcfR
type SparseMatrixType* = SparseMatrixRType|SparseMatrixCType

proc destroySparseMatrix*(this: var SparseMatrixType) {.importcpp: "#.SparseMatrix::~SparseMatrix()", header:"<Eigen/SparseCore>".}

proc makeCompressed(mat:var SparseMatrixType) {.importcpp:"#.makeCompressed()", header:"<Eigen/SparseCore>".}

proc sparseViewC(mat:MatrixXcd):SparseMatrixXcdC {.importcpp:"#.sparseView()", header:"<Eigen/SparseCore>"}
proc sparseViewC(mat:MatrixXcd, reference: Scalar, epsilon:Scalar):SparseMatrixXcdC {.importcpp:"#.sparseView(#,#)", header:"<Eigen/SparseCore>"}
proc sparseViewC(mat:MatrixXcf):SparseMatrixXcfC {.importcpp:"#.sparseView()", header:"<Eigen/SparseCore>"}
proc sparseViewC(mat:MatrixXcf, reference: Scalar, epsilon:Scalar):SparseMatrixXcfC {.importcpp:"#.sparseView(#,#)", header:"<Eigen/SparseCore>"}
proc sparseViewC(mat:MatrixXd):SparseMatrixXdC {.importcpp:"#.sparseView()", header:"<Eigen/SparseCore>"}
proc sparseViewC(mat:MatrixXd, reference: Scalar, epsilon:Scalar):SparseMatrixXdC {.importcpp:"#.sparseView(#,#)", header:"<Eigen/SparseCore>"}
proc sparseViewC(mat:MatrixXf):SparseMatrixXfC {.importcpp:"#.sparseView()", header:"<Eigen/SparseCore>"}
proc sparseViewC(mat:MatrixXf, reference: Scalar, epsilon:Scalar):SparseMatrixXfC {.importcpp:"#.sparseView(#,#)", header:"<Eigen/SparseCore>"}

proc csc_matrix*(mat:MatrixXcd):SparseMatrixXcdC=
  result = mat.sparseViewC()
  result.makeCompressed()

proc csc_matrix*(mat:MatrixXcf):SparseMatrixXcfC=
  result = mat.sparseViewC()
  result.makeCompressed()

proc csc_matrix*(mat:MatrixXd):SparseMatrixXdC=
  result = mat.sparseViewC()
  result.makeCompressed()

proc csc_matrix*(mat:MatrixXf):SparseMatrixXfC=
  result = mat.sparseViewC()
  result.makeCompressed()

proc sparseViewR(mat:MatrixXcd):SparseMatrixXcdR {.importcpp:"SparseMatrixXcdR(#.sparseView())", header:"<Eigen/SparseCore>"}
proc sparseViewR(mat:MatrixXcd, reference: Scalar, epsilon:Scalar):SparseMatrixXcdR {.importcpp:"SparseMatrixXcdR(#.sparseView(#,#))", header:"<Eigen/SparseCore>"}
proc sparseViewR(mat:MatrixXcf):SparseMatrixXcfR {.importcpp:"SparseMatrixXcfR(#.sparseView())", header:"<Eigen/SparseCore>"}
proc sparseViewR(mat:MatrixXcf, reference: Scalar, epsilon:Scalar):SparseMatrixXcfR {.importcpp:"SparseMatrixXcfR(#.sparseView(#,#))", header:"<Eigen/SparseCore>"}
proc sparseViewR(mat:MatrixXd):SparseMatrixXdR {.importcpp:"SparseMatrixXdR(#.sparseView())", header:"<Eigen/SparseCore>"}
proc sparseViewR(mat:MatrixXd, reference: Scalar, epsilon:Scalar):SparseMatrixXdR {.importcpp:"SparseMatrixXdR(#.sparseView(#,#))", header:"<Eigen/SparseCore>"}
proc sparseViewR(mat:MatrixXf):SparseMatrixXfR {.importcpp:"SparseMatrixXfR(#.sparseView())", header:"<Eigen/SparseCore>"}
proc sparseViewR(mat:MatrixXf, reference: Scalar, epsilon:Scalar):SparseMatrixXfR {.importcpp:"SparseMatrixXfR(#.sparseView(#,#))", header:"<Eigen/SparseCore>"}

proc csr_matrix*(mat:MatrixXcd):SparseMatrixXcdR=
  result = mat.sparseViewR()
  result.makeCompressed()

proc csr_matrix*(mat:MatrixXcf):SparseMatrixXcfR=
  result = mat.sparseViewR()
  result.makeCompressed()

proc csr_matrix*(mat:MatrixXd):SparseMatrixXdR=
  result = mat.sparseViewR()
  result.makeCompressed()

proc csr_matrix*(mat:MatrixXf):SparseMatrixXfR=
  result = mat.sparseViewR()
  result.makeCompressed()


proc tocsc*(mat:SparseMatrixXcdR):SparseMatrixXcdC {.importcpp:"SparseMatrixXcdC(#)", header:"<Eigen/SparseCore>".}
proc tocsc*(mat:SparseMatrixXcfR):SparseMatrixXcfC {.importcpp:"SparseMatrixXcfC(#)", header:"<Eigen/SparseCore>".}
proc tocsc*(mat:SparseMatrixXdR):SparseMatrixXdC {.importcpp:"SparseMatrixXdC(#)", header:"<Eigen/SparseCore>".}
proc tocsc*(mat:SparseMatrixXfR):SparseMatrixXfC {.importcpp:"SparseMatrixXfC(#)", header:"<Eigen/SparseCore>".}

proc tocsr*(mat:SparseMatrixXcdC):SparseMatrixXcdR {.importcpp:"SparseMatrixXcdR(#)", header:"<Eigen/SparseCore>".}
proc tocsr*(mat:SparseMatrixXcfC):SparseMatrixXcfR {.importcpp:"SparseMatrixXcfR(#)", header:"<Eigen/SparseCore>".}
proc tocsr*(mat:SparseMatrixXdC):SparseMatrixXdR {.importcpp:"SparseMatrixXdR(#)", header:"<Eigen/SparseCore>".}
proc tocsr*(mat:SparseMatrixXfC):SparseMatrixXfR {.importcpp:"SparseMatrixXfR(#)", header:"<Eigen/SparseCore>".}



proc todense*(mat:SparseMatrixXcdC):MatrixXcd {.importcpp:"Eigen::MatrixXcd(#)", header:"<Eigen/SparseCore>".}
proc todense*(mat:SparseMatrixXcfC):MatrixXcf {.importcpp:"Eigen::MatrixXcf(#)", header:"<Eigen/SparseCore>".}
proc todense*(mat:SparseMatrixXdC):MatrixXd {.importcpp:"Eigen::MatrixXd(#)", header:"<Eigen/SparseCore>".}
proc todense*(mat:SparseMatrixXfC):MatrixXf {.importcpp:"Eigen::MatrixXf(#)", header:"<Eigen/SparseCore>".}
proc todense*(mat:SparseMatrixXcdR):MatrixXcd {.importcpp:"Eigen::MatrixXcd(#)", header:"<Eigen/SparseCore>".}
proc todense*(mat:SparseMatrixXcfR):MatrixXcf {.importcpp:"Eigen::MatrixXcf(#)", header:"<Eigen/SparseCore>".}
proc todense*(mat:SparseMatrixXdR):MatrixXd {.importcpp:"Eigen::MatrixXd(#)", header:"<Eigen/SparseCore>".}
proc todense*(mat:SparseMatrixXfR):MatrixXf {.importcpp:"Eigen::MatrixXf(#)", header:"<Eigen/SparseCore>".}

proc `$`*(mat:SparseMatrixType):string= $(mat.todense())

proc issparse*(mat:SparseMatrixType):bool=true
proc issparse*[T](mat:T):bool=false
proc isspmatrix*(mat:SparseMatrixType):bool=true
proc isspmatrix*[T](mat:T):bool=false
proc isspmatrix_csr*(mat:SparseMatrixRType):bool=true
proc isspmatrix_csr*[T](mat:T):bool=false
proc isspmatrix_csc*(mat:SparseMatrixCType):bool=true
proc isspmatrix_csc*[T](mat:T):bool=false

proc rows(mat:SparseMatrixType):int {.importcpp:"#.rows()", header:"<Eigen/SparseCore>".}
proc cols(mat:SparseMatrixType):int {.importcpp:"#.cols()", header:"<Eigen/SparseCore>".}
proc get_shape*(mat:SparseMatrixType):tuple[rows:int,cols:int]=(mat.rows(),mat.cols())
