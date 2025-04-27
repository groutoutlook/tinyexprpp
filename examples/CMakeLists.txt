project(te_demo)

cmake_minimum_required(VERSION 4.0)
set(CMAKE_CXX_STANDARD 23)

add_executable(${PROJECT_NAME} tedemo.cpp)
target_link_libraries(${PROJECT_NAME} PRIVATE tinyexprpp)
set_target_properties(${PROJECT_NAME} PROPERTIES CXX_STANDARD 23)
