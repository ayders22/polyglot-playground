include("${CMAKE_CURRENT_LIST_DIR}/../../../../cmake/PlaygroundTargets.cmake")
playground_setup_project(hello_world_c C)

playground_add_library(11 src/hello_world.c)

if(NOT BUILD_TESTING)
    return()
endif()

playground_add_unity_test(tests/test_hello_world.c)
