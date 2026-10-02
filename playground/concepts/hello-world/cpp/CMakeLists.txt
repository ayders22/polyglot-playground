cmake_minimum_required(VERSION 3.20)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    project(hello_world_cpp VERSION 0.1.0 LANGUAGES CXX)
    include(CTest)
endif()

add_library(hello_world_cpp STATIC src/hello_world.cpp)
target_include_directories(hello_world_cpp PUBLIC include)
target_compile_features(hello_world_cpp PUBLIC cxx_std_17)
set_target_properties(hello_world_cpp PROPERTIES CXX_EXTENSIONS OFF)

set(HELLO_WORLD_WARNINGS -Wall -Wextra -Wpedantic -Werror)
target_compile_options(hello_world_cpp PRIVATE ${HELLO_WORLD_WARNINGS})

if(NOT BUILD_TESTING)
    return()
endif()

add_executable(hello_world_cpp_tests tests/test_hello_world.cpp)
target_link_libraries(hello_world_cpp_tests PRIVATE hello_world_cpp)
target_compile_options(hello_world_cpp_tests PRIVATE ${HELLO_WORLD_WARNINGS})
add_test(NAME hello-world-cpp COMMAND hello_world_cpp_tests)
