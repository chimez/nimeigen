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
