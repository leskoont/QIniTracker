#ifndef FILEMANAGER_H
#define FILEMANAGER_H

#include <QObject>

class FileManager : public QObject
{
    Q_OBJECT

public:
    explicit FileManager(QObject *parent = nullptr);

    Q_INVOKABLE QString openFileDialog(const QString &title = "Open File",
                                     const QString &filter = "Battle Tracker files (*.btl)");
    Q_INVOKABLE QString saveFileDialog(const QString &title = "Save File",
                                     const QString &filter = "Battle Tracker files (*.btl)");
    Q_INVOKABLE bool fileExists(const QString &filePath);
    Q_INVOKABLE QString getFileName(const QString &filePath);
    Q_INVOKABLE QString getFileExtension(const QString &filePath);

signals:
    void fileOpened(const QString &filePath);
    void fileSaved(const QString &filePath);
};

#endif
