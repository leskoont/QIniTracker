#include "FileManager.h"
#include <QFileDialog>
#include <QFileInfo>
#include <QStandardPaths>

FileManager::FileManager(QObject *parent)
    : QObject(parent)
{
}

QString FileManager::openFileDialog(const QString &title, const QString &filter)
{
    QString documentsPath = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);
    QString filePath = QFileDialog::getOpenFileName(nullptr, title, documentsPath, filter);

    if (!filePath.isEmpty()) {
        emit fileOpened(filePath);
    }

    return filePath;
}

QString FileManager::saveFileDialog(const QString &title, const QString &filter)
{
    QString documentsPath = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);
    QString filePath = QFileDialog::getSaveFileName(nullptr, title, documentsPath, filter);

    if (!filePath.isEmpty()) {

        if (!filePath.endsWith(".btl")) {
            filePath += ".btl";
        }
        emit fileSaved(filePath);
    }

    return filePath;
}

bool FileManager::fileExists(const QString &filePath)
{
    return QFileInfo::exists(filePath);
}

QString FileManager::getFileName(const QString &filePath)
{
    QFileInfo fileInfo(filePath);
    return fileInfo.baseName();
}

QString FileManager::getFileExtension(const QString &filePath)
{
    QFileInfo fileInfo(filePath);
    return fileInfo.suffix();
}
