import complex except Complex32, Complex64
import ../../../nimeigen
import ./common
import math
import options


const TOO_SMALL_STEP* = "Required step size is less than spacing between numbers."

type OdeSolverState* = enum
  running, stop, finishe, failed

type OdeSolver*[T:MatrixType] =object of RootObj
  t_old*:Option[float64]
  t*:float64
  fun*:OdeFun[T]
  y*:T
  t_bound*:float64
  direction*:int
  n*:int
  nfev*,njev*,nlu*:int
  status*:OdeSolverState

method initOdeSolver*[T:MatrixType](self:var OdeSolver[T],fun:OdeFun[T], t0:float64, y0:T, t_bound:float64){.base.}=
  self.t_old = none(float64)
  self.t = t0
  self.fun = fun
  self.y = y0
  # self._fun, result.y = check_arguments(fun, y0, support_complex)
  self.t_bound = t_bound
  # self.vectorized = vectorized

  # if vectorized:
  #     def fun_single(t, y):
  #         return self._fun(t, y[:, None]).ravel()
  #     fun_vectorized = self._fun
  # else:
  #     fun_single = self._fun

  #     def fun_vectorized(t, y):
  #         f = np.empty_like(y)
  #         for i, yi in enumerate(y.T):
  #             f[:, i] = self._fun(t, yi)
  #         return f

  # def fun(t, y):
  #     self.nfev += 1
  #     return self.fun_single(t, y)

  # self.fun = fun
  # self.fun_single = fun_single
  # self.fun_vectorized = fun_vectorized

  if t_bound != t0:
    self.direction = sgn(t_bound - t0)
  else:
    self.direction = 1
  self.n = self.y.size
  self.status = running

  self.nfev = 0
  self.njev = 0
  self.nlu = 0



method step_size*[T:MatrixType](self:OdeSolver[T]):Option[float64]{.base.}=
  if self.t_old.isNone():
    result = none(float64)
  else:
    result = some(abs(self.t - self.t_old.get()))

# method step_impl[T:MatrixType](self:var OdeSolver[T]):tuple[state:bool,message:Option[string]]{.base.}=echo "sss"

method step_base*[T:MatrixType](self:var OdeSolver[T], step_impl: proc(self:var OdeSolver[T]):tuple[state:bool,message:Option[string]]):Option[string]{.base.}=
  ## Perform one integration step.

  ## Returns
  ## -------
  ## message : string or None
  ##     Report from the solver. Typically a reason for a failure if
  ##     `self.status` is 'failed' after the step was taken or None
  ##     otherwise.

  if not (self.status == running):
      raise newException(ValueError,"Attempt to step on a failed or finished solver.")

  if self.n == 0 or self.t == self.t_bound:
    # Handle corner cases of empty solver or no integration.
    self.t_old = some(self.t)
    self.t = self.t_bound
    let message = none(string)
    self.status = finishe
    result = message
  else:
    let t = self.t
    let (success, message) = self.step_impl()
    # echo success

    if not success:
      self.status = failed
    else:
      self.t_old = some(t)
      if float64(self.direction) * (self.t - self.t_bound) >= 0:
        self.status = finishe

    result = message

