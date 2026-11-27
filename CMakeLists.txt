cmake_minimum_required(VERSION 3.20)

project(polyglot_playground VERSION 0.1.0 LANGUAGES C CXX)

include(CTest)

option(BUILD_BENCHMARKING "Build benchmarks" OFF)
set(PROJECT_PATH "" CACHE STRING "Project path relative to playground")

set(PLAYGROUND_DIR "${CMAKE_CURRENT_SOURCE_DIR}/playground")
set(C_FAMILY_LANGUAGES c cpp)
set(C_FAMILY_LANGUAGE "" CACHE STRING "C-family implementation language to build (c or cpp)")

if(C_FAMILY_LANGUAGE)
    if(NOT C_FAMILY_LANGUAGE IN_LIST C_FAMILY_LANGUAGES)
        message(FATAL_ERROR "Unsupported C-family language: ${C_FAMILY_LANGUAGE}")
    endif()
    set(C_FAMILY_LANGUAGES "${C_FAMILY_LANGUAGE}")
endif()

include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/ProjectDiscovery.cmake")
find_project_cmakelists(
    PROJECT_CMAKELISTS
    "${CMAKE_CURRENT_SOURCE_DIR}"
    "${PLAYGROUND_DIR}"
    "${PROJECT_PATH}"
    "${C_FAMILY_LANGUAGES}")

if(BUILD_BENCHMARKING)
    enable_testing()
    find_package(benchmark CONFIG REQUIRED)
endif()

foreach(project_cmakelists IN LISTS PROJECT_CMAKELISTS)
    cmake_path(GET project_cmakelists PARENT_PATH project_dir)
    add_subdirectory("${project_dir}")
endforeach()
