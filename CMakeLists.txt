cmake_minimum_required(VERSION 3.20)

project(polyglot_playground VERSION 0.1.0 LANGUAGES C CXX)

include(CTest)

option(BUILD_BENCHMARKING "Build benchmarks" OFF)
set(EXERCISE_PATH "" CACHE STRING "Exercise path relative to exercises")

if(EXERCISE_PATH)
    set(C_EXERCISE_FILES "")
    foreach(language IN ITEMS c cpp)
        set(language_exercise_file "playground/${EXERCISE_PATH}/${language}/CMakeLists.txt")
        if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${language_exercise_file}")
            list(APPEND C_EXERCISE_FILES "${language_exercise_file}")
        endif()
    endforeach()

    if(NOT C_EXERCISE_FILES)
        message(FATAL_ERROR "No C or C++ implementation for exercise: ${EXERCISE_PATH}")
    endif()
else()
    file(
        GLOB_RECURSE C_EXERCISE_FILES
        CONFIGURE_DEPENDS
        RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
        "${CMAKE_CURRENT_SOURCE_DIR}/playground/*/CMakeLists.txt")
    list(FILTER C_EXERCISE_FILES INCLUDE REGEX "/(c|cpp)/CMakeLists\\.txt$")
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

foreach(c_exercise_file IN LISTS C_EXERCISE_FILES)
    cmake_path(GET c_exercise_file PARENT_PATH c_exercise_dir)
    add_subdirectory("${c_exercise_dir}")
endforeach()
