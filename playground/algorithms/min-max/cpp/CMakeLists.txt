cmake_minimum_required(VERSION 3.20)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    project(min_max_cpp VERSION 0.1.0 LANGUAGES CXX)
    include(CTest)
endif()

add_library(min_max_cpp STATIC src/min_max.cpp)
target_include_directories(min_max_cpp PUBLIC include)
target_compile_features(min_max_cpp PUBLIC cxx_std_17)
set_target_properties(min_max_cpp PROPERTIES CXX_EXTENSIONS OFF)

set(MIN_MAX_WARNINGS -Wall -Wextra -Wpedantic -Werror)
target_compile_options(min_max_cpp PRIVATE ${MIN_MAX_WARNINGS})

if(NOT BUILD_TESTING)
    return()
endif()

add_executable(min_max_cpp_tests tests/test_min_max.cpp)
target_link_libraries(min_max_cpp_tests PRIVATE min_max_cpp)
target_compile_options(min_max_cpp_tests PRIVATE ${MIN_MAX_WARNINGS})
add_test(NAME min-max-cpp COMMAND min_max_cpp_tests)
