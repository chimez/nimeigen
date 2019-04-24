import complex except Complex32, Complex64
import ../../../nimeigen/matrix
import ./rk
import ./common
import ./base
import options

proc solve_ivp*[T:MatrixType](fun:OdeFun[T], t_span:tuple[t_start,t_end:float64], y0:T):tuple[t:seq[float64], y:seq[T]]=
  let t0 = t_span.t_start
  let tf = t_span.t_end
  var solver:RK45[T]
  initRK45[T](solver, fun, t0, y0, tf)
  var ts:seq[float64]
  var ys:seq[T]
  var status = none(int)

  while status.isNone():
    let message = solver.step()

    if solver.status == finishe:
      status = some(0)
    elif solver.status == failed:
      status = some(-1)
      break

    let t_old = solver.t_old
    let t = solver.t
    let y = solver.y

    ts.add(t)
    ys.add(y)

  result.t = ts
  result.y = ys


