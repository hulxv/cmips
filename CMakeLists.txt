project(CiscifyMips)

cmake_minimum_required(VERSION 3.10)

set(SOURCES
    src/main.c
)

add_executable(cmips ${SOURCES})