#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>
#include <QtQml>

#include "Character.h"
#include "CharacterModel.h"
#include "FileManager.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setApplicationName("QIniTracker");
    app.setApplicationVersion("2.0");
    app.setOrganizationName("D&D Tools");
    app.setOrganizationDomain("dndtools.com");


    qmlRegisterType<Character>("QIniTracker", 1, 0, "Character");
    qmlRegisterType<CharacterModel>("QIniTracker", 1, 0, "CharacterModel");
    qmlRegisterType<FileManager>("QIniTracker", 1, 0, "FileManager");

    QQmlApplicationEngine engine;


    CharacterModel characterModel;
    FileManager fileManager;


    engine.rootContext()->setContextProperty("characterModel", &characterModel);
    engine.rootContext()->setContextProperty("fileManager", &fileManager);


    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));


    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
