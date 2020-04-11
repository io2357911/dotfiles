include(../toolchain.pri)
include(../build.pri)

TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += \
    src/driver/state.cpp \
    src/driver/driver.cpp \
    src/voip/voip.cpp \
    src/voip/camera.cpp \
    src/main.cpp \
    src/voipd.cpp

HEADERS += \
    src/driver/state.h \
    src/driver/driver.h \
    src/voip/voip.h \
    src/voip/camera.h \
    src/voipd.h \
    src/defines.h

INCLUDEPATH += \
    ../libtoolbox/include

DEPENDPATH += \
    ../libtoolbox/include

LIBS += \
    -L../libtoolbox/build/$$PLATFORM/$$CONFIG_NAME -ltoolbox \
    -llinphone -lmediastreamer_base -lmediastreamer_voip -lortp -lbctoolbox \
    -lubus -lubox \
    -lconfig++ \
    -lpthread
