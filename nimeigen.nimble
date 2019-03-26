# Package

version       = "0.0.1"
author        = "chimez"
description   = "high level wrap of Eigen, the fundamental package for scientific computing with Nim"
license       = "MPL2"
srcDir        = "src"


# Dependencies

requires "nim >= 0.19.9"

# tests
task test, "all tests":
  exec "nim cpp --path:./src --passc:\"-I/usr/include/eigen3\" --run tests/tests.nim"

task test_matrix, "test all matrix functions":
  exec "nim cpp --path:./src --passc:\"-I/usr/include/eigen3\" --run tests/test_matrix.nim"

task test_complex, "test all complex functions":
  exec "nim cpp --path:./src --passc:\"-I/usr/include/eigen3\" --run tests/test_complex.nim"


