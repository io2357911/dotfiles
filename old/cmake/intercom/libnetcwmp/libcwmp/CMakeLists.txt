cmake_minimum_required(VERSION 2.8)

set(PROJ_NAME cwmp)

project(${PROJ_NAME})

add_definitions(-DUSE_CWMP_OPENSSL -DUSE_CWMP_MEMORY_POOL)

set(SOURCES
    src/buffer.c
    src/callback.c
    src/cfg.c
    src/cwmp.c
    src/event.c
    src/http.c
    src/ini.c
    src/log.c
    src/md5.c
    src/memory.c
    src/model.c
    src/queue.c
    src/session.c
    src/ssl.c
    src/util.c
)

add_library(${PROJ_NAME} STATIC ${SOURCES})

target_include_directories(${PROJ_NAME} PUBLIC
	${PROJECT_SOURCE_DIR}/include
	${PROJECT_SOURCE_DIR}/src/inc
    ${PROJECT_SOURCE_DIR}/../libpool/include
    ${PROJECT_SOURCE_DIR}/../libxmlet/include
)

