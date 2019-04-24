import sequtils
import complex except Complex32, Complex64
import ../../../nimeigen
import ./common
import ./base
import options
import math

# Multiply steps computed from asymptotic behaviour of errors by this.
const SAFETY = 0.9

const MIN_FACTOR = 0.2  # Minimum allowed decrease in a step size.
const MAX_FACTOR = 10  # Maximum allowed increase in a step size.





proc rk_step[T:MatrixType](fun: OdeFun[T], t:float64, y:T, f:T, h:float64, A:seq[T], B:T, C:seq[float64], E:T, K:var T):tuple[y_new,f_new,error:T]=
  K[0] = f
  for s, (a, c) in zip(A, C):
    let dy = a * K[_..(s+1)] * h
    K[s + 1] = fun(t + c * h, y + dy)

  let y_new = y + h * B * K[_..(-1)]
  let f_new = fun(t+h, y_new)
  K[-1] = f_new
  let error = (E * K) * h

  return (y_new, f_new, error)





type RungeKutta[T:MatrixType] = object of OdeSolver[T]
  y_old:Option[T]
  max_step:float64
  rtol:float64
  atol:float64
  f:T
  n_stages:int
  K:T
  order:float64
  h_abs:float64
  C:seq[float64]
  A:seq[T]
  B:T
  E:T
  # P:seq[seq[float64]]

method initRungeKutta[T:MatrixType](self:var RungeKutta[T], fun: OdeFun[T], t0:float64, y0:T, t_bound:float64, max_step:float64=Inf,rtol:float64=1e-3, atol:float64=1e-6,first_step:Option[float64]=none(float64)){.base.}=
  initOdeSolver(self,fun , t0, y0, t_bound)
  self.y_old = none(T)
  self.max_step = validate_max_step(max_step)
  (self.rtol, self.atol) = validate_tol(rtol, atol)
  self.f = self.fun(self.t, self.y)

  if first_step.isNone():
    self.h_abs = select_initial_step[T](
      self.fun, self.t, self.y, self.f, self.direction,
      self.order, self.rtol, self.atol)
  else:
    self.h_abs = validate_first_step(first_step.get(), t0, t_bound)
  self.K = matrix((self.n_stages + 1, self.n))

proc step_impl[T:MatrixType](self:var RungeKutta[T]):tuple[state:bool,message:Option[string]]=
    let
      t = self.t
      y = self.y
      max_step = self.max_step
      rtol = self.rtol
      atol = self.atol
      min_step = 10 * abs((t + self.direction * EPS) - t)

    var h_abs:float64
    if self.h_abs > max_step:
        h_abs = max_step
    elif self.h_abs < min_step:
        h_abs = min_step
    else:
        h_abs = self.h_abs

    let
      order = self.order
    var
      step_accepted = false
      h:float64
      t_new:float64
      y_new:T
      f_new:T

    while not step_accepted:
      if h_abs < min_step:
        result = (false, some(TOO_SMALL_STEP))
        return

      h = h_abs * float64(self.direction)
      t_new = t + h

      if float64(self.direction) * (t_new - self.t_bound) > 0:
        t_new = self.t_bound

      h = t_new - t
      h_abs = abs(h)

      let
         rk_step_result = rk_step(self.fun, t, y, self.f, h, self.A,
                                    self.B, self.C, self.E, self.K)

      y_new = rk_step_result.y_new
      f_new = rk_step_result.f_new
      let error = rk_step_result.error

      let scale = atol + maximum(abs(y), abs(y_new)) * rtol

      let error_norm = norm(error ./ scale)

      if error_norm == 0.0:
        h_abs *= MAX_FACTOR
        step_accepted = true
      elif error_norm < 1:
        h_abs *= min(MAX_FACTOR,
                      max(1, SAFETY * error_norm .pow (-1 / (order + 1))))
        step_accepted = true
      else:
        h_abs *= max(MIN_FACTOR,
                      SAFETY * error_norm .pow (-1 / (order + 1)))

    self.y_old = some(y)

    self.t = t_new
    self.y = y_new

    self.h_abs = h_abs
    self.f = f_new

    result = (true, none(string))


method step*[T:MatrixType](self:var RungeKutta[T]):Option[string]{.base.}=self.step_base(step_impl[T])



type RK23*[T:MatrixType] = object of RungeKutta[T]

method initRK23*[T](self:var RK23[T], fun: OdeFun[T], t0:float64, y0:T, t_bound:float64, max_step:float64=Inf,rtol:float64=1e-3, atol:float64=1e-6,first_step:Option[float64]=none(float64))=
  self.order = 2
  self.n_stages = 3
  self.C = @[1/2, 3/4]
  self.A = @[matrix([[1/2]], dtype=T),
             matrix([[0.0, 3/4]], dtype=T)]
  self.B = matrix([[2/9, 1/3, 4/9]], dtype=T)
  self.E = matrix([[5/72, -1/12, -1/9, 1/8]], dtype=T)
  # self.P = @[@[1, -4 / 3, 5 / 9],
  #            @[0, 1, -2/3],
  #            @[0, 4/3, -8/9],
  #            @[0, -1, 1]]

  initRungeKutta(self, fun, t0, y0, t_bound, max_step,rtol, atol,first_step)

type RK45*[T:MatrixType] = object of RungeKutta[T]
method initRK45*[T](self:var RK45[T], fun: OdeFun[T], t0:float64, y0:T, t_bound:float64, max_step:float64=Inf,rtol:float64=1e-3, atol:float64=1e-6,first_step:Option[float64]=none(float64))=
  self.order =  4
  self.n_stages =  6
  self.C = @[1/5, 3/10, 4/5, 8/9, 1]
  self.A = @[matrix([[1/5]], dtype=T),
             matrix([[3/40, 9/40]], dtype=T),
             matrix([[44/45, -56/15, 32/9]], dtype=T),
             matrix([[19372/6561, -25360/2187, 64448/6561, -212/729]], dtype=T),
             matrix([[9017/3168, -355/33, 46732/5247, 49/176, -5103/18656]], dtype=T)]
  self.B = matrix([[35/384, 0, 500/1113, 125/192, -2187/6784, 11/84]], dtype=T)
  self.E = matrix([[-71/57600, 0, 71/16695, -71/1920, 17253/339200, -22/525,  1/40]], dtype=T)
  # self.P =  @[@[1.0, -8048581381.0/2820520608, 8663915743.0/2820520608,
  #     -12715105075.0/11282082432],
  #   @[0, 0, 0, 0],
  #   @[0, 131558114200.0/32700410799, -68118460800.0/10900136933,
  #     87487479700.0/32700410799],
  #   @[0, -1754552775.0/470086768, 14199869525.0/1410260304,
  #     -1069076397var/188034707none(int)
  #   @[0, 127303824393.0/49829197408, -318862633887.0/49829197408,
  #     701980252875 / 19931678.63],()
  #   @[0, -282668133let .0/205662961, 2019193451.0/616988883, -1453857185.0/822651844],
  #   @[0, 40617522.0/29380423, -110615467.0/29380423, 69997945.0/29380423]]

  initRungeKutta(self, fun, t0, y0, t_bound, max_step,rtol, atol,first_step)



