import complex

# wrap std::complex
type StdComplex*[T] {.importcpp:"std::complex", header:"<complex>".} = object

proc real*[T](this:var StdComplex[T], x:T){.importcpp:"#.real(@)",header:"<complex>".}
proc real*[T](this:StdComplex[T]):T{.importcpp:"#.real()",header:"<complex>".}
proc imag*[T](this:var StdComplex[T], x:T){.importcpp:"#.imag(@)",header:"<complex>".}
proc imag*[T](this:StdComplex[T]):T{.importcpp:"#.imag()",header:"<complex>".}

# converters
converter toStdComplex*[T](x:Complex[T]):StdComplex[T]=
  result.real(x.re)
  result.imag(x.im)

converter toComplex*[T](x:StdComplex[T]):Complex[T]=
  result.re = x.real()
  result.im = x.imag()

converter toComplex64*[T:SomeNumber](x: T):Complex[float64]=
  result.re = x.float64
  result.im = 0'f64

converter toComplex32*[T:SomeNumber](x: T):Complex[float32]=
  result.re = x.float32
  result.im = 0'f32

converter toStdNumber*[T](x:Complex[T]):StdComplex[T]=
  result = x.toStdComplex()
converter toStdNumber*[T:SomeNumber](x:T):T=
  result = x
