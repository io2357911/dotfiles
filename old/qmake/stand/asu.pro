include(../build.pri)

QT += core gui network sql script

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets printsupport
CONFIG += c++14
TARGET = asu
TEMPLATE = app

DEFINES += QT_DEPRECATED_WARNINGS

INCLUDEPATH += $$PWD/../lib/modbus/include
INCLUDEPATH += $$PWD/../lib/libxlsxwriter/include
INCLUDEPATH += $$PWD/../lib/xlnt/include

win32 {
    LIBS += -lNetapi32 -lOle32
    LIBS += -L$$PWD/../lib/modbus -lmodbus-5
    LIBS += -L$$PWD/../lib/libxlsxwriter/win -lXlsxWriter
    LIBS += -L$$PWD/../lib/xlnt/win -lxlnt -lstudxml
    LIBS += -L$$PWD/../lib/zlib -lZlib

    QMAKE_CXXFLAGS += -mno-ms-bitfields

    DEFINES += APP_NAME=\\\"$$join(TARGET, '', '', '.exe')\\\"
}

unix {
#    DEFINES += QCUSTOMPLOT_USE_OPENGL

    LIBS += -L$$PWD/../lib/modbus -lmodbus
    LIBS += -L$$PWD/../lib/libxlsxwriter/linux -lxlsxwriter
    LIBS += -L$$PWD/../lib/xlnt/linux -lxlnt
    LIBS += -lz

    DEFINES += APP_NAME=\\\"$$TARGET\\\"
}

win32:RC_ICONS += icon.ico

SOURCES += \
    main.cpp \
    view/mainwindow.cpp \
    view/devicesdialog.cpp \
    view/qcustomplot.cpp \
    view/plot.cpp \
    tools/tools.cpp \
    tools/user.cpp \
    tools/semaphore.cpp \
    device/device.cpp \
    device/register.cpp \
    device/udpserver.cpp \
    device/modbusslave.cpp \
    data/table.cpp \
    app.cpp \
    tools/file.cpp \
    data/db.cpp \
    data/program.cpp \
    view/programdialog.cpp \
    view/dischargesdialog.cpp \
    view/calibraiondialog.cpp \
    tools/noisevalue.cpp \
    data/product.cpp \
    view/itemsdialog.cpp \
    view/productsdialog.cpp \
    view/productdialog.cpp \
    view/dischargedialog.cpp \
    view/programsdialog.cpp \
    data/discharge.cpp \
    data/permissions.cpp \
    data/stategraph.cpp \
    view/permissionsdialog.cpp \
    view/permissionswidget.cpp \
    view/reportdialog.cpp \
    data/report.cpp \
    data/adc.cpp \
    device/activator.cpp \
    view/keywidget.cpp \
    device/key.cpp \
    view/deviceresistancewidget.cpp \
    view/graph/graphwidget.cpp \
    view/graph/statewidget.cpp \
    view/graph/statepropertiesdialog.cpp \
    view/graph/transitionpropertiesdialog.cpp \
    view/graph/transitionwidget.cpp \
    view/conditiondialog.cpp \
    view/actiondialog.cpp \
    tools/timer.cpp \
    view/resistancesequencedialog.cpp \
    view/circuitwidget.cpp \
    view/resistancesdialog.cpp \
    view/resistancedialog.cpp \
    view/channelswidget.cpp \
    view/colorsdialog.cpp \
    data/color.cpp \
    view/plotparamwidget.cpp \
    view/plotparamsdialog.cpp \
    view/plotdeviceparamswidget.cpp

HEADERS += \
    defines.h \
    view/mainwindow.h \
    view/devicesdialog.h \
    view/qcustomplot.h \
    view/plot.h \
    tools/tools.h \
    tools/user.h \
    tools/mutex.h \
    tools/semaphore.h \
    tools/ini.h \
    device/device.h \
    device/register.h \
    device/udpserver.h \
    device/modbusslave.h \
    data/table.h \
    app.h \
    tools/taskqueue.h \
    tools/file.h \
    data/db.h \
    data/program.h \
    view/programdialog.h \
    view/dischargesdialog.h \
    data/discharge.h \
    view/calibraiondialog.h \
    tools/noisevalue.h \
    data/product.h \
    view/itemsdialog.h \
    view/productsdialog.h \
    view/productdialog.h \
    view/dischargedialog.h \
    view/programsdialog.h \
    interfaces.h \
    data/permissions.h \
    view/permissionsdialog.h \
    view/permissionswidget.h \
    view/reportdialog.h \
    exception.h \
    data/report.h \
    data/adc.h \
    device/activator.h \
    types.h \
    view/keywidget.h \
    device/key.h \
    view/deviceresistancewidget.h \
    data/graph.h \
    data/stategraph.h \
    view/graph/graphwidget.h \
    view/graph/statewidget.h \
    view/graph/statepropertiesdialog.h \
    view/graph/transitionpropertiesdialog.h \
    view/graph/transitionwidget.h \
    view/conditiondialog.h \
    view/actiondialog.h \
    tools/timer.h \
    view/resistancesequencedialog.h \
    view/circuitwidget.h \
    view/resistancesdialog.h \
    view/resistancedialog.h \
    view/channelswidget.h \
    view/colorsdialog.h \
    data/color.h \
    view/plotparamwidget.h \
    view/plotparamsdialog.h \
    view/plotdeviceparamswidget.h

FORMS += \
    view/mainwindow.ui \
    view/plot.ui \
    view/devicesdialog.ui \
    view/programdialog.ui \
    view/calibraiondialog.ui \
    view/itemsdialog.ui \
    view/productdialog.ui \
    view/dischargedialog.ui \
    view/permissionsdialog.ui \
    view/permissionswidget.ui \
    view/reportdialog.ui \
    view/keywidget.ui \
    view/deviceresistancewidget.ui \
    view/graph/graphwidget.ui \
    view/graph/statewidget.ui \
    view/graph/statepropertiesdialog.ui \
    view/graph/transitionpropertiesdialog.ui \
    view/graph/transitionwidget.ui \
    view/conditiondialog.ui \
    view/actiondialog.ui \
    view/resistancesequencedialog.ui \
    view/circuitwidget.ui \
    view/resistancesdialog.ui \
    view/resistancedialog.ui \
    view/channelswidget.ui \
    view/colorsdialog.ui \
    view/plotparamwidget.ui \
    view/plotparamsdialog.ui \
    view/plotdeviceparamswidget.ui

RESOURCES += \
    pics.qrc
