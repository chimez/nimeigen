import complex
import unittest
import nimeigen
include nimeigen/eigentype


suite "test sparse matrix":
  test "convert from/to dense matrix":
    let mat = rand(100)
    let smr = csr_matrix(mat)
    let smc = csc_matrix(mat)
    check: allclose(mat, smr.todense())
    check: allclose(mat, smc.todense())
    check: allclose(mat, smc.tocsr().todense())
    check: issparse(smr)
    check: not issparse(mat)
    check: isspmatrix_csr(smr)
    check: smr.get_shape() == (100,100)

  test "operators + - * /":
    let
      m1 = rand(5)
      m2 = rand(5)
      s = complex64(1,2)
      mres1 = m1 + m2
      mres2 = m1 - m2
      mres3 = m1 * m2
      mres4 = m1 / s
      mres5 = m1 * s
      mres6 = s * m1

    let
      r1 = csr_matrix(m1)
      r2 = csr_matrix(m2)
      rres1 = r1 + r2
      rres2 = r1 - r2
      rres3 = r1 * r2
      rres4 = r1 / s
      rres5 = r1 * s
      rres6 = s * r1

    check: allclose(mres1, rres1.todense())
    check: allclose(mres2, rres2.todense())
    check: allclose(mres3, rres3.todense())
    check: allclose(mres4, rres4.todense())
    check: allclose(mres5, rres5.todense())
    check: allclose(mres6, rres6.todense())

    let
      c1 = csc_matrix(m1)
      c2 = csc_matrix(m2)
      cres1 = c1 + c2
      cres2 = c1 - c2
      cres3 = c1 * c2
      cres4 = c1 / s
      cres5 = c1 * s
      cres6 = s * c1

    check: allclose(mres1, cres1.todense())
    check: allclose(mres2, cres2.todense())
    check: allclose(mres3, cres3.todense())
    check: allclose(mres4, cres4.todense())
    check: allclose(mres5, cres5.todense())
    check: allclose(mres6, cres6.todense())

    let
      mm1 = m1 * m2
      mm2 = m2 * m1
      rmres1 = r1 * m2
      mrres1 = m1 * r2
      cmres1 = c1 * m2
      mcres1 = m1 * c2

    check: allclose(rmres1, mm1)
    check: allclose(mrres1, mm1)
    check: allclose(cmres1, mm1)
    check: allclose(mcres1, mm1)


