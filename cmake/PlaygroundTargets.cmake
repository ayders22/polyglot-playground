set(PLAYGROUND_WARNINGS -Wall -Wextra -Wpedantic -Werror)

function(playground_setup_project language)
    if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
        playground_get_target_prefix(project_name)
        project(${project_name} VERSION 0.1.0 LANGUAGES ${language})
        include(CTest)
    endif()
endfunction()

function(playground_get_target_prefix output_variable)
    cmake_path(GET CMAKE_CURRENT_SOURCE_DIR PARENT_PATH exercise_directory)
    cmake_path(GET exercise_directory FILENAME exercise_name)
    cmake_path(GET CMAKE_CURRENT_SOURCE_DIR FILENAME language_name)
    string(REPLACE "-" "_" exercise_name "${exercise_name}")
    set(${output_variable} "${exercise_name}_${language_name}" PARENT_SCOPE)
endfunction()

function(playground_get_language_name output_variable)
    cmake_path(GET CMAKE_CURRENT_SOURCE_DIR FILENAME language_name)
    if(language_name STREQUAL "cpp")
        set(language_name "cxx")
    endif()
    set(${output_variable} "${language_name}" PARENT_SCOPE)
endfunction()

function(playground_add_library source)
    playground_get_language_name(language)
    playground_get_target_prefix(target_prefix)
    string(TOUPPER "${language}" language_upper)

    if(language STREQUAL "c")
        set(standard 11)
    elseif(language STREQUAL "cxx")
        set(standard 17)
    else()
        message(FATAL_ERROR "Unsupported library language: ${language}")
    endif()

    add_library(${target_prefix} STATIC ${source})
    target_include_directories(${target_prefix} PUBLIC include)
    target_compile_features(${target_prefix} PUBLIC ${language}_std_${standard})
    target_compile_options(${target_prefix} PRIVATE ${PLAYGROUND_WARNINGS})
    set_target_properties(${target_prefix} PROPERTIES ${language_upper}_EXTENSIONS OFF)
endfunction()

function(playground_get_benchmark_source output_variable)
    cmake_path(GET CMAKE_CURRENT_SOURCE_DIR PARENT_PATH exercise_directory)
    cmake_path(GET exercise_directory FILENAME exercise_name)
    string(REPLACE "-" "_" exercise_name "${exercise_name}")
    set(${output_variable} "${CMAKE_CURRENT_SOURCE_DIR}/benchmarks/${exercise_name}.cc" PARENT_SCOPE)
endfunction()

function(playground_add_test source)
    playground_get_target_prefix(target_prefix)
    set(test_target "${target_prefix}_tests")
    file(STRINGS
        "${CMAKE_CURRENT_SOURCE_DIR}/${source}"
        test_case_definitions
        REGEX "^[ \t]*(static[ \t]+)?void[ \t]+test_[A-Za-z0-9_]+[ \t]*\\("
    )

    add_executable(${test_target} ${source})
    target_link_libraries(${test_target} PRIVATE ${target_prefix} ${ARGN})
    target_compile_options(${test_target} PRIVATE ${PLAYGROUND_WARNINGS})

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

function(playground_add_unity_test source)
    if(NOT TARGET unity::framework)
        include(FetchContent)

        FetchContent_Declare(
            unity
            GIT_REPOSITORY https://github.com/ThrowTheSwitch/Unity.git
            GIT_TAG v2.7.0
        )
        FetchContent_MakeAvailable(unity)
    endif()

    playground_add_test(${source} unity::framework)
endfunction()

function(playground_add_benchmark test_name)
    playground_get_target_prefix(target_prefix)
    playground_get_benchmark_source(benchmark_source)
    set(benchmark_target "${target_prefix}_benchmarks")

    if(NOT EXISTS "${benchmark_source}")
        message(FATAL_ERROR "Benchmark source not found: ${benchmark_source}")
    endif()

    add_executable(${benchmark_target} ${benchmark_source})
    target_link_libraries(${benchmark_target} PRIVATE ${target_prefix} benchmark::benchmark_main)
    target_compile_features(${benchmark_target} PRIVATE cxx_std_17)
    target_compile_options(${benchmark_target} PRIVATE ${PLAYGROUND_WARNINGS})
    set_target_properties(${benchmark_target} PROPERTIES CXX_EXTENSIONS OFF)
    add_test(NAME ${test_name} COMMAND ${benchmark_target})
    set_tests_properties(${test_name} PROPERTIES LABELS benchmark)
endfunction()