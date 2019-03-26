import complex except Complex32, Complex64
from nimeigen import Complex32, Complex64
import nimeigen as np

proc eigs(x:MatrixXcd):MatrixXcd {.exportc.}=
  result=x.eigenvalues()
