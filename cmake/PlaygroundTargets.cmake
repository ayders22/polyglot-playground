set(PLAYGROUND_WARNINGS -Wall -Wextra -Wpedantic -Werror)

function(playground_add_library target language standard source)
    string(TOUPPER "${language}" language_upper)

    add_library(${target} STATIC ${source})
    target_include_directories(${target} PUBLIC include)
    target_compile_features(${target} PUBLIC ${language}_std_${standard})
    target_compile_options(${target} PRIVATE ${PLAYGROUND_WARNINGS})
    set_target_properties(${target} PROPERTIES ${language_upper}_EXTENSIONS OFF)
endfunction()

function(playground_add_test target source library test_name)
    add_executable(${target} ${source})
    target_link_libraries(${target} PRIVATE ${library} ${ARGN})
    target_compile_options(${target} PRIVATE ${PLAYGROUND_WARNINGS})
    add_test(NAME ${test_name} COMMAND ${target})
endfunction()

function(playground_add_unity_test target source library test_name)
    if(NOT TARGET unity::framework)
        include(FetchContent)

        FetchContent_Declare(
            unity
            GIT_REPOSITORY https://github.com/ThrowTheSwitch/Unity.git
            GIT_TAG v2.7.0
        )
        FetchContent_MakeAvailable(unity)
    endif()

    playground_add_test(${target} ${source} ${library} ${test_name} unity::framework)
endfunction()

function(playground_add_benchmark target source library test_name)
    add_executable(${target} ${source})
    target_link_libraries(${target} PRIVATE ${library} benchmark::benchmark_main)
    target_compile_features(${target} PRIVATE cxx_std_17)
    target_compile_options(${target} PRIVATE ${PLAYGROUND_WARNINGS})
    set_target_properties(${target} PROPERTIES CXX_EXTENSIONS OFF)
    add_test(NAME ${test_name} COMMAND ${target})
    set_tests_properties(${test_name} PROPERTIES LABELS benchmark)
endfunction()