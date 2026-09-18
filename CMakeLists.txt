cmake_minimum_required(VERSION 3.21 FATAL_ERROR)
project(cucumber_cpp_development VERSION 1.0.0 LANGUAGES CXX)

# Generate a single aggregate compilation database for the whole super-project.
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

option(CUCUMBER_CPP_DEV_ENABLE_COVERAGE "Enable compiler flags for code coverage measurements." Off)

# Enable testing at the top level so `ctest` recurses into the sub-projects.
include(CTest)

# C++ sub-projects aggregated by this super-project.
add_subdirectory(messages/cpp)
add_subdirectory(gherkin/cpp)

# messages and gherkin don't have proper unit tests, so enable coverage after including messages and gherkin
if(CUCUMBER_CPP_DEV_ENABLE_COVERAGE)
    find_program(GCOVR_PROGRAM gcovr REQUIRED)

    add_custom_target(
        generate-lcov-report
        COMMAND ${GCOVR_PROGRAM} --version
        COMMAND ${GCOVR_PROGRAM} --root ${CMAKE_CURRENT_SOURCE_DIR} --merge-lines --delete --exclude-unreachable-branches --exclude-throw-branches --exclude-noncode-lines --exclude "(^|.*/)include/.*" --exclude "(^|.*/)test/.*"
            --txt-summary
            --lcov ${CMAKE_CURRENT_BINARY_DIR}/lcov.info
            --cobertura ${CMAKE_CURRENT_BINARY_DIR}/cobertura.xml --cobertura-pretty
            --markdown-summary ${CMAKE_CURRENT_BINARY_DIR}/coverage-summary.md
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        COMMENT "Generating code coverage reports"
        VERBATIM
    )

    add_compile_options(
        -g -O0 --coverage -fprofile-arcs -ftest-coverage -fno-inline
        $<$<COMPILE_LANGUAGE:CXX>:-fno-elide-constructors>
    )

    if (CMAKE_C_COMPILER_ID STREQUAL "GNU")
        link_libraries(gcov)
    else()
        add_link_options(--coverage)
    endif()
endif()

add_subdirectory(query/cpp)
add_subdirectory(tag-expressions/cpp)
add_subdirectory(pretty-formatter/cpp)
add_subdirectory(cucumber-expressions/cpp)
