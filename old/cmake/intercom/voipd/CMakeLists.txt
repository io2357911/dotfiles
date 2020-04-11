cmake_minimum_required(VERSION 2.8)

set(PROJ_NAME voipd)

project(${PROJ_NAME})

add_definitions(-std=c++11)

set(SOURCES
    src/driver/state.cpp
    src/driver/driver.cpp
    src/voip/voip.cpp
    src/voip/camera.cpp
    src/main.cpp
    src/voipd.cpp
)

add_executable(${PROJ_NAME} ${SOURCES})

target_link_libraries(${PROJ_NAME} 
    toolbox
    linphone mediastreamer_base mediastreamer_voip ortp bctoolbox
    ubus ubox
    config++
    pthread
)

include_directories(src)

install(TARGETS ${PROJ_NAME} DESTINATION usr/sbin)
install(DIRECTORY ipk/data/ DESTINATION .)
