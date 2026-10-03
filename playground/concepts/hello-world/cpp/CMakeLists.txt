cmake_minimum_required(VERSION 3.20)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    project(hello_world_cpp VERSION 0.1.0 LANGUAGES CXX)
    include(CTest)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/../../../../cmake/PlaygroundTargets.cmake")

playground_add_library(cxx 17 src/hello_world.cpp)

if(NOT BUILD_TESTING)
    return()
endif()

playground_add_test(tests/test_hello_world.cpp)
