cmake_minimum_required(VERSION 2.8)

set(PROJ_NAME netcwmpd)

project(${PROJ_NAME})

add_definitions(-DUSE_CWMP_OPENSSL -DUSE_CWMP_MEMORY_POOL)

set(SOURCES
    main.c
)

add_executable(${PROJ_NAME} ${SOURCES})

target_link_libraries(${PROJ_NAME} 
    netcwmp cwmp xmlet pool pthread ssl crypto
)

include_directories(src)

