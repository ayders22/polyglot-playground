set(COMMON_WARNINGS -Wall -Wextra -Wpedantic -Werror)

function(get_project_name output_variable)
    cmake_path(GET CMAKE_CURRENT_SOURCE_DIR PARENT_PATH project_directory)
    cmake_path(GET project_directory FILENAME project_name)
    string(REPLACE "-" "_" project_name "${project_name}")
    set(${output_variable} "${project_name}" PARENT_SCOPE)
endfunction()

function(get_target_prefix output_variable)
    get_project_name(project_name)
    cmake_path(GET CMAKE_CURRENT_SOURCE_DIR FILENAME language_name)
    set(${output_variable} "${project_name}_${language_name}" PARENT_SCOPE)
endfunction()

macro(configure_standalone_project)
    include(CTest)

    option(BUILD_BENCHMARKING "Build benchmarks" OFF)
    if(BUILD_BENCHMARKING)
        if(NOT CMAKE_CXX_COMPILER_LOADED)
            enable_language(CXX)
        endif()
        find_package(benchmark CONFIG REQUIRED)
    endif()
endmacro()

function(get_language_settings output_language output_extension output_standard)
    cmake_path(GET CMAKE_CURRENT_SOURCE_DIR FILENAME language_name)
    if(language_name STREQUAL "cpp")
        set(language_name "cxx")
    endif()

    if(language_name STREQUAL "c")
        set(source_extension c)
        set(standard 11)
    elseif(language_name STREQUAL "cxx")
        set(source_extension cpp)
        set(standard 17)
    else()
        message(FATAL_ERROR "Unsupported project language: ${language_name}")
    endif()

    set(${output_language} "${language_name}" PARENT_SCOPE)
    set(${output_extension} "${source_extension}" PARENT_SCOPE)
    set(${output_standard} "${standard}" PARENT_SCOPE)
endfunction()

function(add_library_target)
    get_language_settings(language source_extension standard)
    get_target_prefix(target_prefix)
    string(TOUPPER "${language}" language_upper)

    file(GLOB_RECURSE sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/src/*.${source_extension}")
    if(NOT sources)
        message(FATAL_ERROR "No ${language} library sources found in ${CMAKE_CURRENT_SOURCE_DIR}/src")
    endif()

    add_library(${target_prefix} STATIC ${sources})
    target_include_directories(${target_prefix} PUBLIC include)
    target_compile_features(${target_prefix} PUBLIC ${language}_std_${standard})
    target_compile_options(${target_prefix} PRIVATE ${COMMON_WARNINGS})
    set_target_properties(${target_prefix} PROPERTIES ${language_upper}_EXTENSIONS OFF)
endfunction()

function(get_benchmark_source output_variable)
    get_project_name(project_name)
    set(${output_variable} "${CMAKE_CURRENT_SOURCE_DIR}/benches/${project_name}.cc" PARENT_SCOPE)
endfunction()

function(add_test_target source)
    get_target_prefix(target_prefix)
    set(test_target "${target_prefix}_tests")
    foreach(test_source IN LISTS source)
        file(STRINGS
            "${CMAKE_CURRENT_SOURCE_DIR}/${test_source}"
            source_test_case_definitions
            REGEX "^[ \t]*(static[ \t]+)?void[ \t]+test_[A-Za-z0-9_]+[ \t]*\\("
        )
        list(APPEND test_case_definitions ${source_test_case_definitions})
    endforeach()

    add_executable(${test_target} ${source})
    target_link_libraries(${test_target} PRIVATE ${target_prefix} ${ARGN})
    target_compile_options(${test_target} PRIVATE ${COMMON_WARNINGS})

    set(test_cases)
    foreach(test_case_definition IN LISTS test_case_definitions)
        string(REGEX MATCH "test_[A-Za-z0-9_]+" test_case "${test_case_definition}")
        list(APPEND test_cases "${test_case}")
    endforeach()
    list(REMOVE_DUPLICATES test_cases)

    if(NOT test_cases)
        message(FATAL_ERROR "No test functions found in ${source}")
    endif()

    foreach(test_case IN LISTS test_cases)
        add_test(NAME "${test_case}" COMMAND ${test_target} "${test_case}")
    endforeach()
endfunction()

function(add_unity_test_target)
    if(NOT BUILD_TESTING)
        return()
    endif()

    get_language_settings(language source_extension standard)

    file(
        GLOB_RECURSE test_sources
        CONFIGURE_DEPENDS
        RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
        "${CMAKE_CURRENT_SOURCE_DIR}/tests/*.${source_extension}"
    )
    if(NOT test_sources)
        message(FATAL_ERROR "No ${language} Unity test sources found in ${CMAKE_CURRENT_SOURCE_DIR}/tests")
    endif()

    if(NOT TARGET unity::framework)
        include(FetchContent)

        FetchContent_Declare(
            unity
            GIT_REPOSITORY https://github.com/ThrowTheSwitch/Unity.git
            GIT_TAG v2.7.0
        )
        FetchContent_MakeAvailable(unity)
    endif()

    add_test_target("${test_sources}" unity::framework)
endfunction()

function(add_benchmark_target)
    if(NOT BUILD_BENCHMARKING)
        return()
    endif()

    get_target_prefix(target_prefix)
    get_benchmark_source(benchmark_source)
    if(NOT EXISTS "${benchmark_source}")
        return()
    endif()

    cmake_path(GET CMAKE_CURRENT_SOURCE_DIR PARENT_PATH project_directory)
    cmake_path(GET project_directory FILENAME project_name)
    cmake_path(GET CMAKE_CURRENT_SOURCE_DIR FILENAME language_name)
    set(benchmark_test_name "${project_name}-${language_name}-benchmark")
    set(benchmark_target "${target_prefix}_benchmarks")

    add_executable(${benchmark_target} ${benchmark_source})
    target_link_libraries(${benchmark_target} PRIVATE ${target_prefix} benchmark::benchmark_main)
    target_compile_features(${benchmark_target} PRIVATE cxx_std_17)
    target_compile_options(${benchmark_target} PRIVATE ${COMMON_WARNINGS})
    set_target_properties(${benchmark_target} PROPERTIES CXX_EXTENSIONS OFF)
    add_test(NAME "${benchmark_test_name}" COMMAND ${benchmark_target})
    set_tests_properties("${benchmark_test_name}" PROPERTIES LABELS benchmark)
endfunction()

function(add_project)
    add_library_target()
    add_benchmark_target()
    add_unity_test_target()
endfunction()