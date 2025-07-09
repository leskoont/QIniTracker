QT += core gui qml quick widgets

CONFIG += c++11

TARGET = QIniTracker
TEMPLATE = app





DEFINES += QT_DEPRECATED_WARNINGS





SOURCES += \
    src/main.cpp \
    src/Character.cpp \
    src/CharacterModel.cpp \
    src/FileManager.cpp

HEADERS += \
    src/Character.h \
    src/CharacterModel.h \
    src/FileManager.h

RESOURCES += \
    qml.qrc


QML_IMPORT_PATH =


QML_DESIGNER_IMPORT_PATH =


qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
