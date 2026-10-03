include("${CMAKE_CURRENT_LIST_DIR}/../../../../cmake/PlaygroundTargets.cmake")
playground_setup_project(CXX)

playground_add_library(17 src/hello_world.cpp)

if(NOT BUILD_TESTING)
    return()
endif()

playground_add_test(tests/test_hello_world.cpp)
