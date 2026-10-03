include("${CMAKE_CURRENT_LIST_DIR}/../../../../cmake/PlaygroundTargets.cmake")
playground_setup_project(C)

playground_add_library()

if(BUILD_BENCHMARKING)
    playground_add_benchmark(min-max-c-benchmark)
endif()

if(NOT BUILD_TESTING)
    return()
endif()

playground_add_unity_test()
