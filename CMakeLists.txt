cmake_minimum_required(VERSION 3.20)

project(polyglot_playground VERSION 0.1.0 LANGUAGES C CXX)

include(CTest)

option(BUILD_BENCHMARKING "Build benchmarks" OFF)
set(EXERCISE_PATH "" CACHE STRING "Exercise path relative to playground")

set(PLAYGROUND_DIR "${CMAKE_CURRENT_SOURCE_DIR}/playground")
set(C_FAMILY_LANGUAGES c cpp)
set(EXERCISE_CMAKELISTS)

if(EXERCISE_PATH)
    foreach(language IN LISTS C_FAMILY_LANGUAGES)
        set(exercise_cmakelists "${PLAYGROUND_DIR}/${EXERCISE_PATH}/${language}/CMakeLists.txt")
        if(EXISTS "${exercise_cmakelists}")
            list(APPEND EXERCISE_CMAKELISTS "${exercise_cmakelists}")
        endif()
    endforeach()

    if(NOT EXERCISE_CMAKELISTS)
        message(FATAL_ERROR "No C or C++ implementation for exercise: ${EXERCISE_PATH}")
    endif()
else()
    file(
        GLOB_RECURSE EXERCISE_CMAKELISTS
        CONFIGURE_DEPENDS
        RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
        "${PLAYGROUND_DIR}/*/CMakeLists.txt")
    string(JOIN "|" C_FAMILY_LANGUAGE_PATTERN ${C_FAMILY_LANGUAGES})
    list(FILTER EXERCISE_CMAKELISTS INCLUDE REGEX "/(${C_FAMILY_LANGUAGE_PATTERN})/CMakeLists\\.txt$")
endif()

if(BUILD_BENCHMARKING)
    enable_testing()

    include(FetchContent)

    set(BENCHMARK_ENABLE_INSTALL OFF CACHE BOOL "" FORCE)
    set(BENCHMARK_ENABLE_TESTING OFF CACHE BOOL "" FORCE)

    FetchContent_Declare(
        google_benchmark
        GIT_REPOSITORY https://github.com/google/benchmark.git
        GIT_TAG v1.9.5
    )
    FetchContent_MakeAvailable(google_benchmark)
endif()

foreach(exercise_cmakelists IN LISTS EXERCISE_CMAKELISTS)
    cmake_path(GET exercise_cmakelists PARENT_PATH exercise_dir)
    add_subdirectory("${exercise_dir}")
endforeach()
