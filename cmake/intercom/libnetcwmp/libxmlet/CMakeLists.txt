cmake_minimum_required(VERSION 2.8)

set(PROJ_NAME xmlet)

project(${PROJ_NAME})

add_definitions(-DUSE_CWMP_OPENSSL -DUSE_CWMP_MEMORY_POOL)

set(SOURCES
    src/attr.c
    src/buffer.c
    src/document.c
    src/element.c
    src/list.c
    src/namemap.c
    src/node.c
    src/parser.c
    src/xmlet.c
)

add_library(${PROJ_NAME} STATIC ${SOURCES})

target_include_directories(${PROJ_NAME} PUBLIC
	${PROJECT_SOURCE_DIR}/include
	${PROJECT_SOURCE_DIR}/src/inc
    ${PROJECT_SOURCE_DIR}/../libpool/include
)

