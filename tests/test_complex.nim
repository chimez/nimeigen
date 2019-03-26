import complex except Complex32, Complex64
import unittest
import nimeigen/stdcomplex


suite "test std::complex":
  test "std::complex":
    let c = Complex[float64](re:12,im:11)
    var sc:StdComplex[float64]
    sc.real(12)
    sc.imag(11)

    check: c.toStdComplex() == sc
    check: sc.toComplex() == c
    check: sc.real() == 12
    check: sc.imag() == 11

    let c1 = type(c.toStdNumber()) is type(StdComplex)
    let c2 = type(sc.real().toStdNumber()) is float64
    check: c1
    check: c2

