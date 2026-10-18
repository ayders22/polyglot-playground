cmake_minimum_required(VERSION 3.20)

project(polyglot_playground VERSION 0.1.0 LANGUAGES C CXX)

include(CTest)

option(BUILD_BENCHMARKING "Build benchmarks" OFF)
set(PROJECT_PATH "" CACHE STRING "Project path relative to playground")

set(PLAYGROUND_DIR "${CMAKE_CURRENT_SOURCE_DIR}/playground")
set(C_FAMILY_LANGUAGES c cpp)
set(C_FAMILY_LANGUAGE "" CACHE STRING "C-family implementation language to build (c or cpp)")
set(PROJECT_CMAKELISTS)

if(C_FAMILY_LANGUAGE)
    if(NOT C_FAMILY_LANGUAGE IN_LIST C_FAMILY_LANGUAGES)
        message(FATAL_ERROR "Unsupported C-family language: ${C_FAMILY_LANGUAGE}")
    endif()
    set(C_FAMILY_LANGUAGES "${C_FAMILY_LANGUAGE}")
endif()

if(PROJECT_PATH)
    foreach(language IN LISTS C_FAMILY_LANGUAGES)
        set(project_cmakelists "${PLAYGROUND_DIR}/${PROJECT_PATH}/${language}/CMakeLists.txt")
        if(EXISTS "${project_cmakelists}")
            list(APPEND PROJECT_CMAKELISTS "${project_cmakelists}")
        endif()
    endforeach()

    if(NOT PROJECT_CMAKELISTS)
        message(FATAL_ERROR "No C or C++ implementation for project: ${PROJECT_PATH}")
    endif()
else()
    file(
        GLOB_RECURSE PROJECT_CMAKELISTS
        CONFIGURE_DEPENDS
        RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
        "${PLAYGROUND_DIR}/*/CMakeLists.txt")
    string(JOIN "|" C_FAMILY_LANGUAGE_PATTERN ${C_FAMILY_LANGUAGES})
    list(FILTER PROJECT_CMAKELISTS INCLUDE REGEX "/(${C_FAMILY_LANGUAGE_PATTERN})/CMakeLists\\.txt$")
endif()

if(BUILD_BENCHMARKING)
    enable_testing()
    find_package(benchmark CONFIG REQUIRED)
endif()

foreach(project_cmakelists IN LISTS PROJECT_CMAKELISTS)
    cmake_path(GET project_cmakelists PARENT_PATH project_dir)
    add_subdirectory("${project_dir}")
endforeach()
