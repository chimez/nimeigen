# Eigen of c++ on nim
This is a high level wrap of [Eigen](http://eigen.tuxfamily.org) lib. The fundamental package for scientific computing with Nim and ready for real world.
## Why should you use nimeigen instead of native linear algebra like [Arraymancer](https://github.com/mratsim/Arraymancer)?
1. You want to use nim **now**. However Arraymancer has not finished and it is not ready for all real work. 
2. You have some c/c++ **legacy** codes, and you do not want to rewrite them all.
3. You want a mature **reliable** and fast matrix library with full support for **MKL**.
4. You want seamless operability between nim and Python(numpy) using **Pybind11**.
5. You want to copy your **python** (numpy) code and run it on nim compiler with little change. 
 
## How to
### A easy example
##### 1. First of all, you need Eigen(3.3.7). 
Try `apt-get install libeigen3-dev`, which will install Eigen at `/usr/include/eigen3`.
##### 2. Of course You also need nimeigen. 
`git clone https://github.com/chimez/nimeigen.git`
##### 3. Create your first nimeigen source 
`hello.nim`
```nim
echo "1. import, Complex32 and Complex64 of stdlib complex is realy bad"
import complex except Complex32, Complex64
from nimeigen import Complex32, Complex64
import nimeigen as np # I love numpy

echo "2. data types are float32, float64, complex[float32], complex[float64](default)"
let mat1 = np.matrix([[1,2],[3,4]],dtype=float64)
echo mat1

echo "3. operators are like matlab instead of numpy"
let mat2 = np.matrix([[1,2],[3,4]])
echo ".*"
echo mat2 .* 2
echo "*"
echo mat2 * mat2

echo "4. all functions are like numpy, and may be easier"
let
  mat3 = np.rand(4)
  mat3_vals = np.eigenvalues(mat3)
echo "eigenvalues:"
echo mat3_vals
```
##### 4. Let's compile it!
```bash
nim cpp --path:/Path/to/nimeigen/src --passc:"-I/usr/include/eigen3" --run hello.nim
```
##### 5. You will see
```
1. import, Complex32 and Complex64 of stdlib complex is realy bad
2. data types are float32, float64, complex[float32], complex[float64](default)
|	1.0	2.0	|
|	3.0	4.0	|
3. operators are like matlab instead of numpy
.*
|	(2.0, 0.0)	(4.0, 0.0)	|
|	(6.0, 0.0)	(8.0, 0.0)	|
*
|	(7.0, 0.0)	(10.0, 0.0)	|
|	(15.0, 0.0)	(22.0, 0.0)	|
4. all functions are like numpy, and may be easier
eigenvalues:
|	(0.1373818674426576, 0.5054111094536585)	|
|	(-0.7576949962329355, 1.215356386483473)	|
|	(1.522050871699843, -0.401625756423867)	|
|	(-0.6912320291028429, -1.625506269422067)	|
```

### How to use MKL?
We don't neet to change any codes!
#### 1. (recommend) use g++
1. generate cpp
```bash
 nim cpp --path:/Path/to/nimeigen/src --passc:"-I/usr/include/eigen3" --nimcache:cppsrc --header hello.nim
```
2. compile
There will be lots of warnings. Don't worry. They are just warnings.
```bash
g++ -o hello cppsrc/*.cpp -I/Path/to/Nim/lib/ -I/usr/include/eigen3 -I/usr/include/mkl `pkg-config --libs mkl-sdl-lp64` -DEIGEN_USE_MKL_ALL
```
3. run it! `./hello`
#### 2. use nim compiler
There may be some bug(?) of nim compiler.
```bash
nim cpp --path:/Path/to/nimeigen/src --passc:"-I/usr/include/eigen3" --passc:"`pkg-config --libs mkl-sdl-lp64`" --passc:"-I/usr/include/mkl" --passc:"-DEIGEN_USE_MKL_ALL" --run a.nim
```

### How to use Pybind11 and any c++ code
Let's write a package which can calculate eigenvalues of matrix. All files are in `examples/pyeigs`.
1. To install pybind11, you can `apt-get install pybind11-dev`
##### 1. write nim code
1. we should add `{.exportc.}` to those we want to use in python.

`eigs.nim`:
```nim 
import complex except Complex32, Complex64
from nimeigen import Complex32, Complex64
import nimeigen as np

proc eigs(x:MatrixXcd):MatrixXcd {.exportc.}=
  result=x.eigenvalues()
```
##### 2. write c++ code
1. pybind11 is quite easy to use.

`pyeigs.cpp`:
```c++
#include <pybind11/complex.h>
#include <pybind11/eigen.h>
#include <pybind11/pybind11.h>
#include <pybind11/stl.h>

#include "eigs.h"

namespace py = pybind11;

PYBIND11_MODULE(pyeigs, m) {
  m.doc() = "nimeigen pybind11 example";
  m.def("eigs", &eigs, "matrix eigenvalues");
}
```
##### 3. write CMakeLists.txt
1. cmake version should > 3.4
2. First, we should compile .nim to .cpp. 
3. We also need set path `NIMEIGEN` and `NIMLIB`
4. finally, compile pybind11 by `pybind11_add_module(pyeigs pyeigs.cpp ${cpp_src})`
```
cmake_minimum_required(VERSION 3.13.4)
project(pyeigs)

# 1. set or find dirs
set(NIMEIGEN "/PATH/to/nimeigen/src")
set(NIMLIB "/PATH/to/Nim/lib")

set(nimsrc ${PROJECT_SOURCE_DIR}/eigs.nim)
set(nimcache ${PROJECT_SOURCE_DIR}/cpp)

find_package(Eigen3 REQUIRED)
find_package(pybind11 REQUIRED)

# 2. compile eigs.nim to *.cpp
add_custom_target(nim ALL
  DEPENDS ${nimsrc})

add_custom_command(TARGET nim
  PRE_BUILD
  COMMAND nim cpp --path:${NIMEIGEN} --passc:"-I${EIGEN3_INCLUDE_DIR}" --nimcache:${nimcache}  --noMain --noLinking --header ${nimsrc}
  COMMENT "compile nim")

# 3. include all header files
include_directories(${EIGEN3_INCLUDE_DIR})
include_directories(${PROJECT_SOURCE_DIR}/cpp)
include_directories(${NIMLIB})
include_directories(${NIMEIGEN})

# 4. compile cpp
file(GLOB cpp_src "${PROJECT_SOURCE_DIR}/cpp/*.cpp")
pybind11_add_module(pyeigs pyeigs.cpp ${cpp_src})
```

##### 4. compile it!
1. we have to run cmake twice, first for nim compiler and second for g++ compiler

```bash
mkdir build
cd build
# first, nim -> cpp
cmake ..
make
# second, cpp -> so
cmake ..
make
```

##### 5. run test.py
1. we should copy .so to same dir, maybe: `cp build/pyeigs.cpython-37m-x86_64-linux-gnu.so .`

`test.py`:
```python
import numpy as np

import pyeigs

mat = np.array([[1, 2j], [3, 4]])
print("numpy:", np.linalg.eigvals(mat))
print("pyeigs:", pyeigs.eigs(mat).transpose())
```

And you will see:
```
numpy: [0.41937476-1.44187427j 4.58062524+1.44187427j]
pyeigs: [[0.41937476-1.44187427j 4.58062524+1.44187427j]]
```

## As a scientific computing library
### ODE solver (Explicit Runge-Kutta method of order 5(4))
This is an example from [scipy's solve_ivp](https://docs.scipy.org/doc/scipy/reference/generated/scipy.integrate.solve_ivp.html#scipy.integrate.solve_ivp ) 

```nim 
import complex except Complex32, Complex64
import nimeigen
import nimeigen/sci/ode/solve_ivp

let y0 = matrix([[2,4,8]])
func exponential_decay(t:float64, y:MatrixXcd):MatrixXcd= -0.5*y
let (t,y) = solve_ivp(exponential_decay, (0.0,10.0), y0)

echo t 
echo y[len(y)-1]
```


## Tips
1. all available functions are listed in `quick_reference.org`
2. `tests/test_matrix.nim` is a good example.
## TODO
1. tensor or ndarray
## Contributing
1. feel free to open an issue for any feature requests, not only wrap Eigen functions but also any numpy/scipy useful functions.
2. Any PR are Welcome.
## License
MPL2, same as Eigen
