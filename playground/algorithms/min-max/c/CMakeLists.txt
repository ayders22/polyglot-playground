cmake_minimum_required(VERSION 3.20)

include("${CMAKE_CURRENT_LIST_DIR}/../../../../cmake/PlaygroundTargets.cmake")
playground_setup_project(min_max_c C)

playground_add_library(11 src/min_max.c)

if(BUILD_BENCHMARKING)
    playground_add_benchmark(min-max-c-benchmark)
endif()

if(NOT BUILD_TESTING)
    return()
endif()

playground_add_unity_test(tests/test_min_max.c)
