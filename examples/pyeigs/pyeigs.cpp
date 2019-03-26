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

