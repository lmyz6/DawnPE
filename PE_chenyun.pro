QT += quick quickcontrols2

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0
#程序版本
VERSION = 1.2.0
#程序图标
#RC_ICONS = icon.ico
#公司名称
QMAKE_TARGET_COMPANY = "lmyz6"
#程序说明
QMAKE_TARGET_DESCRIPTION = "https://lmyz6.cn"
#版权信息
QMAKE_TARGET_COPYRIGHT = "Copyright(C) 2023"
#程序名称
QMAKE_TARGET_PRODUCT = "DawnPE"
#程序语言
#0x0800代表和系统当前语言一致
RC_LANG = 0x0800
#管理员权限获取
CONFIG(debug, debug | release) {
    DESTDIR = ./bin_debug
} else {
    DESTDIR = ./bin_release
    QMAKE_LFLAGS += /MANIFESTUAC:\"level=\'requireAdministrator\' uiAccess=\'false\'\"
}


CONFIG += c++17
SOURCES += \
        download.cpp \
        main.cpp \
        usb.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    download.h \
    usb.h

DISTFILES +=
