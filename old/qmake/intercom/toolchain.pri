contains(PLATFORM, RaspberryPi) {
    #INSTALLS += target
    #    target.path += /home/git/projects/tracker/bin

    TOOLCHAIN_BINUTILS_PATH = /opt/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin
    TOOLCHAIN_INCLUDE_PATH = /opt/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/arm-linux-gnueabihf
    TOOLCHAIN_LIB_PATH = /opt/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/arm-linux-gnueabihf

    QMAKE_CC = $$TOOLCHAIN_BINUTILS_PATH/arm-linux-gnueabihf-gcc-4.8.3
    QMAKE_CXX = $$TOOLCHAIN_BINUTILS_PATH/arm-linux-gnueabihf-g++
    QMAKE_LINK= $$TOOLCHAIN_BINUTILS_PATH/arm-linux-gnueabihf-g++
    QMAKE_LINK_SHLIB = $$TOOLCHAIN_BINUTILS_PATH/arm-linux-gnueabihf-g++

    QMAKE_AR = $$TOOLCHAIN_BINUTILS_PATH/arm-linux-gnueabihf-ar cqs
    QMAKE_OBJCOPY = $$TOOLCHAIN_BINUTILS_PATH/arm-linux-gnueabihf-objcopy
    QMAKE_STRIP = $$TOOLCHAIN_BINUTILS_PATH/arm-linux-gnueabihf-strip

    INCLUDEPATH += \
        $$TOOLCHAIN_INCLUDE_PATH/include \
        $$TOOLCHAIN_INCLUDE_PATH/include/c++/4.8.3 \
        $$TOOLCHAIN_INCLUDE_PATH/include/c++/4.8.3/backward \
        $$TOOLCHAIN_INCLUDE_PATH/include/include/c++/4.8.3/arm-linux-gnueabihf \
        $$TOOLCHAIN_INCLUDE_PATH/libc/usr/include/

    LIBS = \
        -L$$TOOLCHAIN_LIB_PATH/lib \
        -L$$TOOLCHAIN_LIB_PATH/libc
}

contains(PLATFORM, arm) {
    TOOLCHAIN_PREFFIX=arm-poky-linux-gnueabi
    TOOLCHAIN_BINUTILS_PATH = /home/nullptr/proj/intercom/toolchain/x86_64-linux/usr/bin/arm-poky-linux-gnueabi
    TOOLCHAIN_SYSROOT_PATH = /home/nullptr/proj/intercom/toolchain/intercom

    COMPILE_FLAGS = "-march=armv7-a -marm -mfpu=vfpv3  -mfloat-abi=hard --sysroot=$$TOOLCHAIN_SYSROOT_PATH"
#    COMPILE_FLAGS = "-march=armv7-a -mfpu=neon  -mfloat-abi=hard -mcpu=cortex-a8 --sysroot=$$TOOLCHAIN_SYSROOT_PATH"

    QMAKE_CC = "$$TOOLCHAIN_BINUTILS_PATH/$$TOOLCHAIN_PREFFIX-gcc $$COMPILE_FLAGS"
    QMAKE_CXX = "$$TOOLCHAIN_BINUTILS_PATH/$$TOOLCHAIN_PREFFIX-g++ $$COMPILE_FLAGS"
    QMAKE_LINK= $$TOOLCHAIN_BINUTILS_PATH/$$TOOLCHAIN_PREFFIX-g++
    QMAKE_LINK_SHLIB = $$TOOLCHAIN_BINUTILS_PATH/$$TOOLCHAIN_PREFFIX-g++

    QMAKE_AR = $$TOOLCHAIN_BINUTILS_PATH/$$TOOLCHAIN_PREFFIX-ar cqs
    QMAKE_OBJCOPY = $$TOOLCHAIN_BINUTILS_PATH/$$TOOLCHAIN_PREFFIX-objcopy
    QMAKE_STRIP = $$TOOLCHAIN_BINUTILS_PATH/$$TOOLCHAIN_PREFFIX-strip

    QMAKE_INCDIR =
    QMAKE_LFLAGS_RPATH =
    QMAKE_LFLAGS = "-Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed -Wl,--dynamic-linker=/lib/ld-linux-armhf.so.3 --sysroot=$$TOOLCHAIN_SYSROOT_PATH"

    INCLUDEPATH = \
        $$TOOLCHAIN_SYSROOT_PATH/usr/include \
        $$TOOLCHAIN_SYSROOT_PATH/usr/include/c++/4.9.3 \
        $$TOOLCHAIN_SYSROOT_PATH/usr/include/c++/4.9.3/arm-poky-linux-gnueabi
}

#contains(PLATFORM, BeagleBone) {
#    BUILDROOT_PATH=/home/nullptr/projects/linux/3.12.10.sip.release/bin/buildroot
#    TOOLCHAIN_PREFFIX=arm-buildroot-linux-gnueabihf
#    TOOLCHAIN_BINUTILS_PATH = $$BUILDROOT_PATH/host/usr/bin
#    TOOLCHAIN_INCLUDE_PATH = $$BUILDROOT_PATH/host/usr/arm-buildroot-linux-gnueabihf
#    TOOLCHAIN_SYSROOT_PATH = $$BUILDROOT_PATH/host/usr/arm-buildroot-linux-gnueabihf/sysroot
#    TOOLCHAIN_LIB_PATH = $$BUILDROOT_PATH/host/usr/arm-buildroot-linux-gnueabihf/sysroot

#    QMAKE_CC = $$TOOLCHAIN_BINUTILS_PATH/$$TOOLCHAIN_PREFFIX-gcc-4.9.4
#    QMAKE_CXX = $$TOOLCHAIN_BINUTILS_PATH/$$TOOLCHAIN_PREFFIX-g++
#    QMAKE_LINK= $$TOOLCHAIN_BINUTILS_PATH/$$TOOLCHAIN_PREFFIX-g++
#    QMAKE_LINK_SHLIB = $$TOOLCHAIN_BINUTILS_PATH/$$TOOLCHAIN_PREFFIX-g++

#    QMAKE_AR = $$TOOLCHAIN_BINUTILS_PATH/$$TOOLCHAIN_PREFFIX-ar cqs
#    QMAKE_OBJCOPY = $$TOOLCHAIN_BINUTILS_PATH/$$TOOLCHAIN_PREFFIX-objcopy
#    QMAKE_STRIP = $$TOOLCHAIN_BINUTILS_PATH/$$TOOLCHAIN_PREFFIX-strip

#    INCLUDEPATH = \
#        $$TOOLCHAIN_INCLUDE_PATH/include \
#        $$TOOLCHAIN_INCLUDE_PATH/include/c++/4.7.3 \
#        $$TOOLCHAIN_INCLUDE_PATH/include/c++/4.7.3/backward \
#        $$TOOLCHAIN_INCLUDE_PATH/include/c++/4.7.3/arm-linux-gnueabihf \
#        $$TOOLCHAIN_INCLUDE_PATH/usr/include/ \
#        $$TOOLCHAIN_SYSROOT_PATH/usr/include/ \
#        $$TOOLCHAIN_SYSROOT_PATH/usr/include/directfb

#    LIBS = \
#        -L$$TOOLCHAIN_LIB_PATH/lib \
#        -L$$TOOLCHAIN_LIB_PATH/usr/lib
#}

contains(PLATFORM, pc) {
    #INSTALLS += target
    #    target.path += /usr/tracker/bin
}
