cmake_minimum_required(VERSION 2.8)

set(PROJ_NAME netcwmp)

project(${PROJ_NAME})

add_definitions(-DUSE_CWMP_OPENSSL -DUSE_CWMP_MEMORY_POOL)

set(SOURCES
    src/modules/data_model.c
    src/agent.c
    src/conf.c
    src/cwmpd.c
    src/httpd.c
    src/process.c 
    src/thread.c
)

add_library(${PROJ_NAME} STATIC ${SOURCES})

target_include_directories(${PROJ_NAME} PUBLIC
	${PROJECT_SOURCE_DIR}/include
    ${PROJECT_SOURCE_DIR}/../libpool/include
    ${PROJECT_SOURCE_DIR}/../libxmlet/include
    ${PROJECT_SOURCE_DIR}/../libcwmp/include
)

