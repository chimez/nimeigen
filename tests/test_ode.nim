import complex except Complex32, Complex64
import unittest
import nimeigen
import nimeigen/sci/ode

suite "test ode solver":
  test "solve_ivp rk45":
    let y0 = matrix([[2,4,8]])
    func exponential_decay(t:float64, y:MatrixXcd):MatrixXcd= -0.5*y
    let (t,y) = solve_ivp(exponential_decay, (0.0,10.0), y0)

    check: t[len(t)-1] == 10
    check: allclose(y[len(y)-1], matrix([[0.0135, 0.027, 0.054]]), rtol=1e-2, atol=1e-3)
