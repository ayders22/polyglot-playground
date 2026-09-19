cmake_minimum_required(VERSION 3.20)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    project(min_max_c VERSION 0.1.0 LANGUAGES C)
    include(CTest)
endif()

add_library(min_max_c STATIC src/min_max.c)
target_include_directories(min_max_c PUBLIC include)
target_compile_features(min_max_c PUBLIC c_std_11)
set_target_properties(min_max_c PROPERTIES C_EXTENSIONS OFF)

set(MIN_MAX_WARNINGS -Wall -Wextra -Wpedantic -Werror)
target_compile_options(min_max_c PRIVATE ${MIN_MAX_WARNINGS})

if(BUILD_BENCHMARKING)
    add_executable(min_max_c_benchmarks benchmarks/min_max.cc)
    target_link_libraries(min_max_c_benchmarks PRIVATE min_max_c benchmark::benchmark_main)
    target_compile_features(min_max_c_benchmarks PRIVATE cxx_std_17)
    target_compile_options(min_max_c_benchmarks PRIVATE ${MIN_MAX_WARNINGS})

    add_test(NAME min-max-c-benchmark COMMAND min_max_c_benchmarks)
    set_tests_properties(min-max-c-benchmark PROPERTIES LABELS benchmark)
    set_target_properties(min_max_c_benchmarks PROPERTIES C_EXTENSIONS OFF)
endif()

if(NOT BUILD_TESTING)
    return()
endif()

include(FetchContent)

FetchContent_Declare(
    unity
    GIT_REPOSITORY https://github.com/ThrowTheSwitch/Unity.git
    GIT_TAG v2.7.0
)
FetchContent_MakeAvailable(unity)

add_executable(min_max_c_tests tests/test_min_max.c)
target_link_libraries(min_max_c_tests PRIVATE min_max_c unity::framework)
target_compile_options(min_max_c_tests PRIVATE ${MIN_MAX_WARNINGS})
add_test(NAME min-max-c COMMAND min_max_c_tests)
