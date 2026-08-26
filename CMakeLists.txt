cmake_minimum_required(VERSION 3.21 FATAL_ERROR)
project(cucumber_cpp_development VERSION 1.0.0 LANGUAGES CXX)

# Generate a single aggregate compilation database for the whole super-project.
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Enable testing at the top level so `ctest` recurses into the sub-projects.
enable_testing()

# C++ sub-projects aggregated by this super-project.
add_subdirectory(messages/cpp)
add_subdirectory(gherkin/cpp)
add_subdirectory(query/cpp)
add_subdirectory(tag-expressions/cpp)
add_subdirectory(pretty-formatter/cpp)
