cmake_minimum_required(VERSION 3.20)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    project(min_max_c VERSION 0.1.0 LANGUAGES C)
    include(CTest)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/../../../../cmake/PlaygroundTargets.cmake")

playground_add_library(min_max_c c 11 src/min_max.c)

if(BUILD_BENCHMARKING)
    playground_add_benchmark(min_max_c_benchmarks benchmarks/min_max.cc min_max_c min-max-c-benchmark)
endif()

if(NOT BUILD_TESTING)
    return()
endif()

playground_add_unity_test(min_max_c_tests tests/test_min_max.c min_max_c min-max-c)
