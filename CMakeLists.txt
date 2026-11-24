cmake_minimum_required(VERSION 3.10)
project(ciscify_mips C)
set(CMAKE_C_STANDARD 99)
add_compile_options(-Wall -Wextra)

file(GLOB_RECURSE SOURCES src/*.c)
add_executable(cmips ${SOURCES})
target_include_directories(cmips PRIVATE src)
