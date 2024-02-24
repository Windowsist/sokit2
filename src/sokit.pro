# ----------------------------------------------------
# sokit.pro
# ----------------------------------------------------
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TEMPLATE = app
TARGET = sokit

QT += gui widgets network
CONFIG += debug_and_release build_all thread
DEFINES += QT_NETWORK_LIB
INCLUDEPATH += . ./tmp ./sokit
DEPENDPATH += .
UI_DIR += ./tmp
RCC_DIR += ./tmp

win32 {
    #DEFINES += QT_LARGEFILE_SUPPORT
    CONFIG += windows qt_static

    QMAKE_CFLAGS_MT =-MT
    QMAKE_CFLAGS_MT_DBG =-MTd
    QMAKE_CFLAGS_MT_DLL =-MD
    QMAKE_CFLAGS_MT_DLLDBG =-MDd
}

CONFIG(debug, debug|release) {
    DESTDIR = bin/debug
    MOC_DIR += ./tmp/debug
    OBJECTS_DIR += ./tmp/debug
    INCLUDEPATH += ./tmp/debug

    QMAKE_CFLAGS_DEBUG = $$unique(QMAKE_CFLAGS_DEBUG)
    QMAKE_CXXFLAGS_DEBUG = $$unique(QMAKE_CFLAGS_DEBUG)

    CONFIG(qt_static) {
        QMAKE_CFLAGS_DEBUG -= $$QMAKE_CFLAGS_MT_DLLDBG
        QMAKE_CFLAGS_DEBUG += $$QMAKE_CFLAGS_MT_DBG
        QMAKE_CXXFLAGS_DEBUG -= $$QMAKE_CFLAGS_MT_DLLDBG
        QMAKE_CXXFLAGS_DEBUG += $$QMAKE_CFLAGS_MT_DBG
    } else {
        QMAKE_CFLAGS_DEBUG -= $$QMAKE_CFLAGS_MT_DBG
        QMAKE_CFLAGS_DEBUG += $$QMAKE_CFLAGS_MT_DLLDBG
        QMAKE_CXXFLAGS_DEBUG -= $$QMAKE_CFLAGS_MT_DBG
        QMAKE_CXXFLAGS_DEBUG += $$QMAKE_CFLAGS_MT_DLLDBG
    }
} else {
    DESTDIR = bin/release
    MOC_DIR += ./tmp/release
    OBJECTS_DIR += ./tmp/release
    INCLUDEPATH += ./tmp/release

    QMAKE_CFLAGS_RELEASE = $$unique(QMAKE_CFLAGS_RELEASE)
    QMAKE_CXXFLAGS_RELEASE = $$unique(QMAKE_CXXFLAGS_RELEASE)

    CONFIG(qt_static) {
        QMAKE_CFLAGS_RELEASE -= $$QMAKE_CFLAGS_MT_DLL
        QMAKE_CFLAGS_RELEASE += $$QMAKE_CFLAGS_MT
        QMAKE_CXXFLAGS_RELEASE -= $$QMAKE_CFLAGS_MT_DLL
        QMAKE_CXXFLAGS_RELEASE += $$QMAKE_CFLAGS_MT
    } else {
        QMAKE_CFLAGS_RELEASE -= $$QMAKE_CFLAGS_MT
        QMAKE_CFLAGS_RELEASE += $$QMAKE_CFLAGS_MT_DLL
        QMAKE_CXXFLAGS_RELEASE -= $$QMAKE_CFLAGS_MT
        QMAKE_CXXFLAGS_RELEASE += $$QMAKE_CFLAGS_MT_DLL
    }
}

HEADERS += resource.h \
    setting.h \
    toolkit.h \
    baseform.h \
    clientform.h \
    clientskt.h \
    helpform.h \
    logger.h \
    main.h \
    notepadform.h \
    transferskt.h \
    transferform.h \
    serverskt.h \
    serverform.h
SOURCES += baseform.cpp \
    clientform.cpp \
    clientskt.cpp \
    helpform.cpp \
    logger.cpp \
    main.cpp \
    notepadform.cpp \
    serverform.cpp \
    serverskt.cpp \
    setting.cpp \
    toolkit.cpp \
    transferform.cpp \
    transferskt.cpp
FORMS += clientform.ui \
    helpform.ui \
    serverform.ui \
    transferform.ui
TRANSLATIONS += sokit.ts
RESOURCES += icons.qrc

QMAKE_PRE_LINK = lupdate $$PWD/sokit.pro
QMAKE_POST_LINK = lrelease $$PWD/sokit.ts -qm $$DESTDIR/sokit.lan

win32 {
    RC_FILE = sokit.rc
    LIBS += -lWs2_32 -lWinmm -lImm32
    QMAKE_LFLAGS_DEBUG += /PDB:"$$DESTDIR/sokit.pdb"
    QMAKE_CFLAGS_DEBUG += /Fd"$$OBJECTS_DIR/sokit.pdb"
    QMAKE_CXXFLAGS_DEBUG += /Fd"$$OBJECTS_DIR/sokit.pdb"

   CONFIG(qt_static) {
        exists( $(QTDIR)/lib_s ) {
	   QMAKE_LIBDIR_QT = $(QTDIR)/lib_s
       }
    } else {
        exists( $(QTDIR)/lib_d ) {
	   QMAKE_LIBDIR_QT = $(QTDIR)/lib_d
       }
    }
}

OTHER_FILES += \
    sokit.ts \
    LICENSE \
    README.md

