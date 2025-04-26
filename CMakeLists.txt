cmake_minimum_required(VERSION 3.12)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED True)

project(tinyexprpp)

set(TE_BUILD_EXAMPLES OFF CACHE BOOL "Build the example executable")
set(TE_BUILD_TESTS OFF CACHE BOOL "Build the tests executable")

if (PROJECT_IS_TOP_LEVEL)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin-lib")
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin-etc")
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")
endif()


# Main C++ sources
set(TE_SOURCES
    tinyexpr.cpp
)

set(TE_HEADERS
    tinyexpr.h
)
add_library(${PROJECT_NAME} STATIC ${TE_SOURCES} ${TE_HEADERS})
target_include_directories(${PROJECT_NAME}  PUBLIC ".")
target_compile_features(${PROJECT_NAME}  PUBLIC cxx_std_23)

if (TE_BUILD_EXAMPLES)
    add_subdirectory(examples)
endif()

if (TE_BUILD_TESTS)
    add_subdirectory(tests)
endif()
