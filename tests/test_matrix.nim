import complex
import unittest
import nimeigen

suite "test matrix":
  test "new empty matrix & getter & setter":

    var a = matrix(200,200)
    var b = matrix(200,200,float64)
    let cc = complex64(5,2)

    a[1,1] = cc
    b[1,2] = 3

    check: a[1,1] == cc
    check: b[1,2] == 3

    block:
      let m = matrix([[1,2,3],[4,5,6]], float32)
      check: m[0,0] == 1
      check: m[0,1] == 2
      check: m[0,2] == 3
      check: m[1,0] == 4
      check: m[1,1] == 5
      check: m[1,2] == 6

    block:
      let m = matrix([[1,2,3],[4,5,6]])
      check: m[0,0] == 1
      check: m[0,1] == 2
      check: m[0,2] == 3
      check: m[1,0] == 4
      check: m[1,1] == 5
      check: m[1,2] == 6

    block:
      let m = matrix([[1,2,3],[4,5,6]],dtype=float64)
      let s:seq[seq[float64]] = @[@[1.0,2,3],@[4.0,5,6]]
      check: m.toSeq(dtype=type(m[0,0])) == s
      check: allclose(matrix(s,dtype=float64), m)


  test "Runtime info":
    let m = matrix([[1,2,3],[4,5,6]])
    check: m.size == 6
    check: m.rows == 2
    check: m.cols == 3
    check: m.shape == (2,3)

  test "create matrix":
    block:
      var m = matrix(200,300)
      m.fill(20.Complex64)
      check: m[1,2] == 20

    block:
      var m = matrix(200,300,float32)
      m.fill(20.float32)
      check: m[1,2] == 20

    block:
      let m = eye(3)
      check: m[0,0] == 1
      check: m[1,0] == 0

    block:
      let mc = zeros(3,3)
      let m = zeros(3,3,float32)
      check: mc[1,1] == 0
      check: m[1,1] == 0
      check: mc[0,1] == 0
      check: m[0,1] == 0
      check: zeros(3, float32) == m

    block:
      let mc = ones(3)
      let m = ones(3,3,float32)
      check: mc[1,1] == 1
      check: m[1,1] == 1
      check: mc[0,1] == 1
      check: m[0,1] == 1


    block:
      let mc = rand(3)
      let m = rand(3,4,float32)
      let c1 = type(mc[1,2]) is Complex[float64]
      let c2 = type(m[1,2]) is float32
      check: c1
      check: c2

    block:
      let m = linspace(0,1,5)
      let m1 = matrix([[0.0],[0.25],[0.5],[0.75],[1.0]], float64)
      check: allclose(m, m1)

    block:
      var m = matrix(200,300)
      m.fill(20.Complex64)
      let mf = full(200,300,20.Complex64)
      check: m == mf

    block:
      let m1 = matrix([[1,2,3],[4,5,6]])
      let m2 = matrix([[2,3,4],[5,6,7]])
      check: allclose(m1+1, m2)
      check: allclose(1+m1, m2)
      check: allclose(m1, m2-1)
      check: allclose(m1*(-1), 1-m2)

  test "matrix * matrix":
    let m1 = matrix([[2,3,4],[5,6,7]]) * 0.1.Complex64
    let m2 = 10.Complex64 * m1 * m1.transpose().conj()
    let m3 = matrix([[29,56],[56,110]])
    check: m2 == m3

    block:
      let m1 = matrix([[1,2,3],[4,5,6]])
      let m2 = matrix([[1,1,1],[1,1,1]])
      check: allclose(m1 ./ m1, m2)
      check: allclose(m2 .* m2, m2)

  test "astype":
    let m1 = matrix([[1,2,3]],dtype=Complex[float64])
    let m2 = matrix([[1,2,3]],dtype=Complex[float32])
    let m3 = matrix([[1,2,3]],dtype=float64)
    let m4 = matrix([[1,2,3]],dtype=float32)

    check: allclose(m1+m3, m1+m1)

  test "Basic arithmetic reduction operations":
    let m = matrix([[1,2],[3,4]])
    check: m.sum() == 10
    check: m.prod() == 24
    check: m.mean() == 2.5
    check: m.trace() == 5

    let mf = matrix([[1,2],[3,4]], float32)
    check: mf.min() == 1
    check: mf.max() == 4

  test "array function":
    block:
      let m = matrix([[1,2],[3,4]])
      let m1 = matrix([[10,20],[30,40]])
      check: allclose(m .* 10, m1)
      check: allclose(10 .* m, m1)
      check: allclose(10 .* m ./ 10, m)

    block:
      let m = matrix([[complex64(-1,0),complex64(-2,0)],
                         [complex64(3,0),complex64(3,4)]])
      let m1 = matrix([[1,2],[3,5]], float64)
      let absm = m.abs()
      check: allclose(m1, absm)

  test "logic function":
    let m1 = matrix([[1,2],[3,4]])
    let m2 = matrix([[1,2],[3,5]])
    let m3 = matrix([[1,2,3],[3,5,4]])
    let mnt = @[@[true,true],@[true,false]]
    var flag = false
    try:
      discard allclose(m2,m3)
    except ValueError:
      flag = true

    check: isclose(m1,m2) == mnt
    check: allclose(m1, m1)
    check: flag

    block:
      let m1 = matrix([[1,2,3,4]], dtype=float64)
      let m2 = matrix([[0,2,5,3]], dtype=float64)
      let m3 = matrix([[1,2,5,4]], dtype=float64)
      check: allclose(maximum(m1,m2),m3)



  test "math functions":
    let m1 = matrix([[1,2],[3,4]],float64)
    block:
      let m = matrix([[ 0.84147098,  0.90929743],
                      [ 0.14112001, -0.7568025 ]],float64)
      check: allclose(m1.sin(), m)

    block:
      let m = matrix([[ 0.54030231, -0.41614684],
                      [-0.9899925 , -0.65364362]],float64)
      check: allclose(m1.cos(), m)


    block:
      let m = matrix([[1.0       , 1.41421356],
                      [1.73205081, 2.0       ]],float64)
      check: allclose(m1.sqrt(), m)

    block:
      let m = matrix([[ 2.71828183,  7.3890561 ],
                      [20.08553692, 54.59815003]],float64)
      check: allclose(m1.exp(), m)

    block:
      let m = matrix([[0.0       , 0.69314718],
                      [1.09861229, 1.38629436]],float64)
      check: allclose(m1.log(), m)

    block:
      let m = matrix([[      1,    1024],
                      [  59049, 1048576]],float64)
      check: allclose(m1 .^ 10, m)

  test "linalg":
    block:
      let m1 = matrix([[1,2],[3,4]],float64)
      let m2 = matrix([[1,2],[3,4]])
      let m_vals = matrix([[-0.3722813232690144],[5.372281323269015]])
      check: allclose(m_vals,m1.eigenvalues())
      check: allclose(m_vals,m2.eigenvalues())

    block:
      let m = matrix([[ 0,  1,  2,  3],
                      [ 4,  5,  6,  7],
                      [ 8,  9, 10, 11],
                      [12, 13, 14, 15]])
      check: m.norm()-35.213633723<1e-5

  test "accessors":
    block:
      let m = matrix([[ 0,  1,  2,  3],
                      [ 4,  5,  6,  7],
                      [ 8,  9, 10, 11],
                      [12, 13, 14, 15]])
      let mf = matrix([[ 0,  1,  2,  3],
                       [ 4,  5,  6,  7],
                       [ 8,  9, 10, 11],
                       [12, 13, 14, 15]], dtype=float64)
      let m1 = matrix([[ 4,  5,  6,  7],
                       [ 8,  9, 10, 11]])
      let mf1 = matrix([[ 4,  5,  6,  7],
                       [ 8,  9, 10, 11],
                       [12, 13, 14, 15]], dtype=float64)
      let v1 = matrix([[ 4,  5,  6,  7]])

      check: allclose(m[1..3],m1)
      check: allclose(m[_.._],m)
      check: allclose(mf[1.._],mf1)
      check: allclose(m[1],v1)
      check: allclose(m[1..(-1)],m1)

    block:
      let m0 = matrix([[ 0,  1,  2,  3],
                       [ 4,  5,  6,  7],
                       [ 8,  9, 10, 11],
                       [12, 13, 14, 15]])
      var m = matrix([[ 0,  1,  2,  3],
                      [ 4,  5,  6,  7],
                      [ 8,  9, 10, 11],
                      [12, 13, 14, 15]])
      let mv = matrix([[ 0,  1,  2,  3],
                       [ 4,  5,  6,  7],
                       [ 1,  2,  3,  4],
                       [12, 13, 14, 15]])
      let mi = matrix([[1, 2, 3, 4]])
      let mo = matrix([[8, 9, 10, 11]])

      m[2..3] = mi
      check: allclose(m,mv)
      m[-2] = mo
      check: allclose(m,m0)

    block:
      let m = matrix([[ 0,  1,  2,  3],
                      [ 4,  5,  6,  7],
                      [ 8,  9, 10, 11],
                      [12, 13, 14, 15]])
      let m1 = matrix([[ 5,  6],
                       [ 9, 10]])
      check: allclose(m[1..3, 1..3],m1)

    block:
      var m = matrix([[ 0,  1,  2,  3],
                      [ 4,  5,  6,  7],
                      [ 8,  9, 10, 11],
                      [12, 13, 14, 15]])
      let mv = matrix([[ 0,  1,  2,  3],
                       [ 4,  1,  3,  7],
                       [ 8,  2,  4, 11],
                       [12, 13, 14, 15]])
      let m1 = matrix([[ 1,  3],
                       [ 2,  4]])
      m[1..3,1..3]=m1
      check: allclose(m,mv)

  # test "memory":
  #   for i in 0..1000:
  #     let m = rand(10000,10000)
  #     let mm = m * m 

