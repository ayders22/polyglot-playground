cmake_minimum_required(VERSION 3.20)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    project(hello_world_c VERSION 0.1.0 LANGUAGES C)
    include(CTest)
endif()

add_library(hello_world_c STATIC src/hello_world.c)
target_include_directories(hello_world_c PUBLIC include)
target_compile_features(hello_world_c PUBLIC c_std_11)
set_target_properties(hello_world_c PROPERTIES C_EXTENSIONS OFF)

set(HELLO_WORLD_WARNINGS -Wall -Wextra -Wpedantic -Werror)
target_compile_options(hello_world_c PRIVATE ${HELLO_WORLD_WARNINGS})

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

add_executable(hello_world_c_tests tests/test_hello_world.c)
target_link_libraries(hello_world_c_tests PRIVATE hello_world_c unity::framework)
target_compile_options(hello_world_c_tests PRIVATE ${HELLO_WORLD_WARNINGS})
add_test(NAME hello-world-c COMMAND hello_world_c_tests)
