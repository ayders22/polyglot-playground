cmake_minimum_required(VERSION 3.20)

include("${CMAKE_CURRENT_LIST_DIR}/../../../../cmake/Targets.cmake")

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    get_target_prefix(project_name)
    project("${project_name}" VERSION 0.1.0 LANGUAGES CXX)
    configure_standalone_project()
endif()

add_project()
