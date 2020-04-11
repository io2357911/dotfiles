cmake_minimum_required(VERSION 2.8)


# params


# target


set(TARGET "pc" CACHE STRING "target platform arm|pc")

if (${TARGET} STREQUAL "arm")
	set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/toolchain.txt)
endif()


# build type


set(BUILD "release" CACHE STRING "build type debug|release")

if (${BUILD} STREQUAL "release")
	SET(CMAKE_BUILD_TYPE Release CACHE STRING "" FORCE)
elseif (${BUILD} STREQUAL "debug")
	SET(CMAKE_BUILD_TYPE Debug CACHE STRING "" FORCE)
endif()


# misc params


set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3 -Os" CACHE STRING "" FORCE)


# projects


project(intercom)

add_subdirectory(libtoolbox)
add_subdirectory(libnetcwmp)

add_subdirectory(updated)
add_subdirectory(cwmpd)
add_subdirectory(snmpd)
add_subdirectory(voipd)

if (${TARGET} STREQUAL "pc")
    #add_subdirectory(serverd)
endif()

