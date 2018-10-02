include(../toolchain.pri)
include(../build.pri)

TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += \
    src/main.cpp \
    src/snmpd.cpp \
    src/snmp.cpp \
    src/paramd.cpp \
    src/configd.cpp

HEADERS += \
    src/snmpd.h \
    src/snmp.h \
    src/paramd.h \
    src/defines.h \
    src/configd.h

INCLUDEPATH += \
    ../libtoolbox/include

DEPENDPATH += \
    ../libtoolbox/include

LIBS += \
    -L../libtoolbox/build/$$PLATFORM/$$CONFIG_NAME -ltoolbox \
    -lnetsnmpmibs -lnetsnmpagent -lnetsnmp \
    -lubus -lubox \
    -lconfig++ \
    -lpthread
