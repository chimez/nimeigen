import complex except Complex32, Complex64
import strformat
import sugar
import sequtils
import math
import fenv
import ../../../nimeigen


type OdeFun*[T:MatrixType] = proc(t:float64, y:T):T
# proc epsilon_float():float32 {.importcpp:"std::numeric_limits<float>::epsilon()", header:"<limits>".}
# proc epsilon_double():float64 {.importcpp:"std::numeric_limits<double>::epsilon()", header:"<limits>".}
# let EPS* = epsilon_double()
let EPS* = epsilon(float64) * 10

proc validate_first_step*(first_step:float64, t0:float64, t_bound:float64):float64=
  ## Assert that first_step is valid and return it.
  if first_step <= 0:
    raise newException(ValueError,"`first_step` must be positive.")
  if first_step > abs(t_bound - t0):
    raise newException(ValueError,"`first_step` exceeds bounds.")
  result = first_step

proc validate_max_step*(max_step:float64):float64=
  ## Assert that max_Step is valid and return it.
  if max_step <= 0:
    raise newException(ValueError,"`max_step` must be positive.")
  result = max_step

proc validate_tol*(rtol:float64, atol:float64):tuple[tol:float64,atol:float64]=
  ## Validate tolerance values.
  var new_rtol = rtol
  if rtol < 100 * EPS:
    echo(fmt"`rtol` is too low, setting to {100 * EPS}")
    new_rtol = 100 * EPS

  if atol<0:
    raise newException(ValueError,"`atol` must be positive.")

  return (new_rtol, atol)

template make_norm(matrix_type, scalar_type:typedesc):typed=
  proc normRMS*(x:matrix_type):scalar_type=
    ## Compute RMS norm.
    result = x.norm() / abs(sqrt(x.size))

make_norm(MatrixXcd,float64)
make_norm(MatrixXcf,float32)
make_norm(MatrixXd,float64)
make_norm(MatrixXf,float32)

proc select_initial_step*[T:MatrixType](fun:OdeFun[T], t0:float64, y0:T, f0:T, direction:int, order:float64, rtol:float64, atol:float64):float64=
  if y0.size() == 0:
      result = Inf
      return

  let
    scale = atol + y0.abs() * rtol
    d0 = normRMS(y0 ./ scale)
    d1 = normRMS(f0 ./ scale)

  var h0:float64
  if d0 < 1e-5 or d1 < 1e-5:
    h0 = 1e-6
  else:
    h0 = 0.01 * d0 / d1


  let
    y1 = y0 + h0 * direction * f0
    f1 = fun(t0 + h0 * float64(direction), y1)
    d2 = normRMS((f1 - f0) ./ scale) / h0

  var h1:float64
  if d1 <= 1e-15 and d2 <= 1e-15:
    h1 = max(1e-6, h0 * 1e-3)
  else:
    h1 = (0.01 / max(d1, d2)) .pow (1 / (order + 1))

  result = min(100 * h0, h1)


