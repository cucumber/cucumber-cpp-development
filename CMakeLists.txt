cmake_minimum_required(VERSION 3.21 FATAL_ERROR)
project(cucumber_cpp_development VERSION 1.0.0 LANGUAGES CXX)

# Generate a single aggregate compilation database for the whole super-project.
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Enable testing at the top level so `ctest` recurses into the sub-projects.
enable_testing()

# C++ sub-projects aggregated by this super-project.
set(CUCUMBER_CPP_SUBPROJECTS
    messages/cpp
    gherkin/cpp
    query/cpp
)

foreach(subproject IN LISTS CUCUMBER_CPP_SUBPROJECTS)
    add_subdirectory(${subproject})
endforeach()

# Copy the aggregate compilation database into each sub-project so clangd works
# per sub-project in the root build too; clangd ignores the sibling entries.
set(_distribute_compile_commands "")
foreach(subproject IN LISTS CUCUMBER_CPP_SUBPROJECTS)
    list(APPEND _distribute_compile_commands
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
            "${CMAKE_BINARY_DIR}/compile_commands.json"
            "${CMAKE_SOURCE_DIR}/${subproject}/compile_commands.json")
endforeach()
add_custom_target(distribute_compile_commands ALL ${_distribute_compile_commands} VERBATIM)
