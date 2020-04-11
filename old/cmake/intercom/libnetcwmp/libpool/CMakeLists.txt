cmake_minimum_required(VERSION 2.8)

set(PROJ_NAME pool)

project(${PROJ_NAME})

add_definitions(-DUSE_CWMP_OPENSSL -DUSE_CWMP_MEMORY_POOL)

set(SOURCES
    src/pool.c
)

add_library(${PROJ_NAME} STATIC ${SOURCES})

target_include_directories(${PROJ_NAME} PUBLIC
	${PROJECT_SOURCE_DIR}/src
	${PROJECT_SOURCE_DIR}/include
)

