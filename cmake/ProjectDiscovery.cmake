function(is_supported_project_cmakelists output_variable project_cmakelists languages)
    cmake_path(GET project_cmakelists PARENT_PATH project_directory)
    cmake_path(GET project_directory FILENAME project_directory_name)

    if(project_directory_name IN_LIST languages)
        set(is_supported TRUE)
    else()
        cmake_path(GET project_directory PARENT_PATH language_directory)
        cmake_path(GET language_directory FILENAME language_directory_name)
        if(language_directory_name IN_LIST languages)
            set(is_supported TRUE)
        else()
            set(is_supported FALSE)
        endif()
    endif()

    set(${output_variable} "${is_supported}" PARENT_SCOPE)
endfunction()

function(find_project_cmakelists_for_path output_variable playground_directory project_path languages)
    set(project_cmakelists)

    cmake_path(GET project_path PARENT_PATH project_parent)
    cmake_path(GET project_parent FILENAME project_language)

    foreach(language IN LISTS languages)
        set(language_project_cmakelists "${playground_directory}/${project_path}/${language}/CMakeLists.txt")
        if(EXISTS "${language_project_cmakelists}")
            list(APPEND project_cmakelists "${language_project_cmakelists}")
        elseif(project_language STREQUAL language AND
               EXISTS "${playground_directory}/${project_path}/CMakeLists.txt")
            list(APPEND project_cmakelists "${playground_directory}/${project_path}/CMakeLists.txt")
        endif()
    endforeach()

    if(NOT project_cmakelists)
        string(JOIN ", " language_list ${languages})
        message(FATAL_ERROR
            "No implementation found for project '${project_path}' in requested language(s): ${language_list}")
    endif()

    set(${output_variable} "${project_cmakelists}" PARENT_SCOPE)
endfunction()

function(find_supported_project_cmakelists output_variable root_directory playground_directory languages)
    file(
        GLOB_RECURSE all_project_cmakelists
        CONFIGURE_DEPENDS
        RELATIVE "${root_directory}"
        "${playground_directory}/*/CMakeLists.txt")

    set(project_cmakelists)
    foreach(candidate IN LISTS all_project_cmakelists)
        is_supported_project_cmakelists(is_supported "${candidate}" "${languages}")
        if(is_supported)
            list(APPEND project_cmakelists "${candidate}")
        endif()
    endforeach()

    set(${output_variable} "${project_cmakelists}" PARENT_SCOPE)
endfunction()

function(find_project_cmakelists output_variable root_directory playground_directory project_path languages)
    if(project_path)
        find_project_cmakelists_for_path(project_cmakelists
            "${playground_directory}" "${project_path}" "${languages}")
    else()
        find_supported_project_cmakelists(project_cmakelists
            "${root_directory}" "${playground_directory}" "${languages}")
    endif()

    set(absolute_project_cmakelists)
    foreach(candidate IN LISTS project_cmakelists)
        cmake_path(ABSOLUTE_PATH candidate
            BASE_DIRECTORY "${root_directory}"
            NORMALIZE
            OUTPUT_VARIABLE absolute_candidate)
        list(APPEND absolute_project_cmakelists "${absolute_candidate}")
    endforeach()

    set(${output_variable} "${absolute_project_cmakelists}" PARENT_SCOPE)
endfunction()
