#ifndef CHARACTERMODEL_H
#define CHARACTERMODEL_H

#include <QAbstractListModel>
#include "Character.h"

class CharacterModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int currentTurnIndex READ currentTurnIndex WRITE setCurrentTurnIndex NOTIFY currentTurnIndexChanged)
    Q_PROPERTY(int roundNumber READ roundNumber WRITE setRoundNumber NOTIFY roundNumberChanged)

public:
    enum Roles {
        NameRole = Qt::UserRole + 1,
        LevelRole,
        HealthRole,
        ArmorRole,
        InitiativeRole,
        IsActiveRole,
        IsEnemyRole,
        StatusesRole,
        NotesRole,
        StatusTextRole,
        TypeTextRole,
        CharacterObjectRole,
        IsCurrentTurnRole
    };

    explicit CharacterModel(QObject *parent = nullptr);


    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;


    Q_INVOKABLE void addCharacter();
    Q_INVOKABLE void addCharacter(const QString &name, int level, int health, int armor,
                                  int initiative, bool isActive = true, bool isEnemy = false,
                                  const QString &statuses = "", const QString &notes = "");
    Q_INVOKABLE void removeCharacter(int index);
    Q_INVOKABLE void removeAllEnemies();
    Q_INVOKABLE void clearAll();


    Q_INVOKABLE Character* getCharacter(int index) const;
    Q_INVOKABLE void updateCharacter(int index, const QString &name, int level, int health,
                                   int armor, int initiative, bool isActive, bool isEnemy,
                                   const QString &statuses, const QString &notes);


    Q_INVOKABLE void setCharacterActive(int index, bool active);
    Q_INVOKABLE void setCharacterNotes(int index, const QString &notes);


    Q_INVOKABLE void applyDamage(int index, int damage);
    Q_INVOKABLE void applyHealing(int index, int healing);


    Q_INVOKABLE void nextTurn();
    Q_INVOKABLE void previousTurn();
    Q_INVOKABLE void resetTurn();
    Q_INVOKABLE QString getCurrentCharacterName() const;


    Q_INVOKABLE void nextRound();
    Q_INVOKABLE void resetRound();


    Q_INVOKABLE void sortByInitiative();


    Q_INVOKABLE void saveToFile(const QString &filePath);
    Q_INVOKABLE void loadFromFile(const QString &filePath);
    Q_INVOKABLE void addFromFile(const QString &filePath);
    Q_INVOKABLE void autoSave();
    Q_INVOKABLE void autoLoad();


    Q_INVOKABLE int characterCount() const { return m_characters.size(); }


    int currentTurnIndex() const { return m_currentTurnIndex; }
    int roundNumber() const { return m_roundNumber; }


    void setCurrentTurnIndex(int index);
    void setRoundNumber(int round);

signals:
    void characterAdded(int index);
    void characterRemoved(int index);
    void characterUpdated(int index);
    void modelCleared();
    void currentTurnIndexChanged();
    void roundNumberChanged();
    void turnChanged(const QString &characterName);
    void roundChanged(int roundNumber);

private slots:
    void onCharacterChanged();

private:
    QList<Character*> m_characters;
    int m_currentTurnIndex;
    int m_roundNumber;

    void connectCharacterSignals(Character* character);
    void disconnectCharacterSignals(Character* character);
    int findCharacterIndex(Character* character);
    int getNextActiveCharacterIndex(int startIndex) const;
    int getPreviousActiveCharacterIndex(int startIndex) const;
};

#endif
