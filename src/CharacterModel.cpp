#include "CharacterModel.h"
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QFile>
#include <QDebug>
#include <QStandardPaths>
#include <algorithm>
#include <QDir>

CharacterModel::CharacterModel(QObject *parent)
    : QAbstractListModel(parent)
    , m_currentTurnIndex(-1)
    , m_roundNumber(1)
{
}

int CharacterModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_characters.size();
}

QVariant CharacterModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_characters.size())
        return QVariant();

    Character* character = m_characters.at(index.row());

    switch (role) {
    case NameRole:
        return character->name();
    case LevelRole:
        return character->level();
    case HealthRole:
        return character->health();
    case ArmorRole:
        return character->armor();
    case InitiativeRole:
        return character->initiative();
    case IsActiveRole:
        return character->isActive();
    case IsEnemyRole:
        return character->isEnemy();
    case StatusesRole:
        return character->statuses();
    case NotesRole:
        return character->notes();
    case StatusTextRole:
        return character->statusText();
    case TypeTextRole:
        return character->typeText();
    case CharacterObjectRole:
        return QVariant::fromValue(character);
    case IsCurrentTurnRole:
        return index.row() == m_currentTurnIndex;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> CharacterModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[LevelRole] = "level";
    roles[HealthRole] = "health";
    roles[ArmorRole] = "armor";
    roles[InitiativeRole] = "initiative";
    roles[IsActiveRole] = "isActive";
    roles[IsEnemyRole] = "isEnemy";
    roles[StatusesRole] = "statuses";
    roles[NotesRole] = "notes";
    roles[StatusTextRole] = "statusText";
    roles[TypeTextRole] = "typeText";
    roles[CharacterObjectRole] = "characterObject";
    roles[IsCurrentTurnRole] = "isCurrentTurn";
    return roles;
}

void CharacterModel::addCharacter()
{
    beginInsertRows(QModelIndex(), m_characters.size(), m_characters.size());
    Character* character = new Character(this);
    connectCharacterSignals(character);
    m_characters.append(character);
    endInsertRows();

    emit characterAdded(m_characters.size() - 1);
}

void CharacterModel::addCharacter(const QString &name, int level, int health, int armor,
                                 int initiative, bool isActive, bool isEnemy,
                                 const QString &statuses, const QString &notes)
{
    beginInsertRows(QModelIndex(), m_characters.size(), m_characters.size());
    Character* character = new Character(name, level, health, armor, initiative,
                                       isActive, isEnemy, statuses, notes, this);
    connectCharacterSignals(character);
    m_characters.append(character);
    endInsertRows();

    emit characterAdded(m_characters.size() - 1);
}

void CharacterModel::removeCharacter(int index)
{
    if (index < 0 || index >= m_characters.size())
        return;

    beginRemoveRows(QModelIndex(), index, index);
    Character* character = m_characters.takeAt(index);
    disconnectCharacterSignals(character);
    character->deleteLater();
    endRemoveRows();

    emit characterRemoved(index);
}

void CharacterModel::removeAllEnemies()
{
    for (int i = m_characters.size() - 1; i >= 0; --i) {
        if (m_characters.at(i)->isEnemy()) {
            removeCharacter(i);
        }
    }
}

void CharacterModel::clearAll()
{
    beginResetModel();
    for (Character* character : m_characters) {
        disconnectCharacterSignals(character);
        character->deleteLater();
    }
    m_characters.clear();
    endResetModel();

    emit modelCleared();
}

Character* CharacterModel::getCharacter(int index) const
{
    if (index < 0 || index >= m_characters.size())
        return nullptr;
    return m_characters.at(index);
}

void CharacterModel::updateCharacter(int index, const QString &name, int level, int health,
                                   int armor, int initiative, bool isActive, bool isEnemy,
                                   const QString &statuses, const QString &notes)
{
    if (index < 0 || index >= m_characters.size())
        return;

    Character* character = m_characters.at(index);
    character->setName(name);
    character->setLevel(level);
    character->setHealth(health);
    character->setArmor(armor);
    character->setInitiative(initiative);
    character->setIsActive(isActive);
    character->setIsEnemy(isEnemy);
    character->setStatuses(statuses);
    character->setNotes(notes);

    emit characterUpdated(index);
}

void CharacterModel::setCharacterActive(int index, bool active)
{
    if (index < 0 || index >= m_characters.size())
        return;

    Character* character = m_characters.at(index);
    character->setIsActive(active);
}

void CharacterModel::setCharacterNotes(int index, const QString &notes)
{
    if (index < 0 || index >= m_characters.size())
        return;

    Character* character = m_characters.at(index);
    character->setNotes(notes);
}

void CharacterModel::sortByInitiative()
{
    beginResetModel();
    std::sort(m_characters.begin(), m_characters.end(),
              [](const Character* a, const Character* b) {
                  return a->initiative() > b->initiative();
              });
    endResetModel();
}

void CharacterModel::saveToFile(const QString &filePath)
{
    QJsonDocument doc;
    QJsonArray charactersArray;

    for (Character* character : m_characters) {
        charactersArray.append(character->toJson());
    }

    doc.setArray(charactersArray);

    QFile file(filePath);
    if (file.open(QIODevice::WriteOnly)) {
        file.write(doc.toJson());
        file.close();
        qDebug() << "Characters saved to:" << filePath;
    } else {
        qWarning() << "Failed to save characters to:" << filePath;
    }
}

void CharacterModel::loadFromFile(const QString &filePath)
{
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning() << "Failed to load characters from:" << filePath;
        return;
    }

    QByteArray data = file.readAll();
    file.close();

    QJsonDocument doc = QJsonDocument::fromJson(data);
    if (!doc.isArray()) {
        qWarning() << "Invalid JSON format in file:" << filePath;
        return;
    }


    clearAll();


    QJsonArray charactersArray = doc.array();
    for (const QJsonValue& value : charactersArray) {
        if (value.isObject()) {
            Character* character = new Character(this);
            character->fromJson(value.toObject());

            beginInsertRows(QModelIndex(), m_characters.size(), m_characters.size());
            connectCharacterSignals(character);
            m_characters.append(character);
            endInsertRows();
        }
    }

    sortByInitiative();
    qDebug() << "Characters loaded from:" << filePath;
}

void CharacterModel::addFromFile(const QString &filePath)
{
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning() << "Failed to load characters from:" << filePath;
        return;
    }

    QByteArray data = file.readAll();
    file.close();

    QJsonDocument doc = QJsonDocument::fromJson(data);
    if (!doc.isArray()) {
        qWarning() << "Invalid JSON format in file:" << filePath;
        return;
    }


    QJsonArray charactersArray = doc.array();
    for (const QJsonValue& value : charactersArray) {
        if (value.isObject()) {
            Character* character = new Character(this);
            character->fromJson(value.toObject());

            beginInsertRows(QModelIndex(), m_characters.size(), m_characters.size());
            connectCharacterSignals(character);
            m_characters.append(character);
            endInsertRows();
        }
    }

    sortByInitiative();
    qDebug() << "Characters added from:" << filePath;
}

void CharacterModel::onCharacterChanged()
{
    Character* character = qobject_cast<Character*>(sender());
    if (!character)
        return;

    int index = findCharacterIndex(character);
    if (index >= 0) {
        QModelIndex modelIndex = createIndex(index, 0);
        emit dataChanged(modelIndex, modelIndex);
        emit characterUpdated(index);
    }
}

void CharacterModel::connectCharacterSignals(Character* character)
{
    connect(character, &Character::nameChanged, this, &CharacterModel::onCharacterChanged);
    connect(character, &Character::levelChanged, this, &CharacterModel::onCharacterChanged);
    connect(character, &Character::healthChanged, this, &CharacterModel::onCharacterChanged);
    connect(character, &Character::armorChanged, this, &CharacterModel::onCharacterChanged);
    connect(character, &Character::initiativeChanged, this, &CharacterModel::onCharacterChanged);
    connect(character, &Character::isActiveChanged, this, &CharacterModel::onCharacterChanged);
    connect(character, &Character::isEnemyChanged, this, &CharacterModel::onCharacterChanged);
    connect(character, &Character::statusesChanged, this, &CharacterModel::onCharacterChanged);
    connect(character, &Character::notesChanged, this, &CharacterModel::onCharacterChanged);
}

void CharacterModel::disconnectCharacterSignals(Character* character)
{
    disconnect(character, nullptr, this, nullptr);
}

int CharacterModel::findCharacterIndex(Character* character)
{
    for (int i = 0; i < m_characters.size(); ++i) {
        if (m_characters.at(i) == character) {
            return i;
        }
    }
    return -1;
}


void CharacterModel::nextTurn()
{
    if (m_characters.isEmpty())
        return;

    int nextIndex = getNextActiveCharacterIndex(m_currentTurnIndex);


    if (nextIndex != -1 && nextIndex <= m_currentTurnIndex && m_currentTurnIndex != -1) {
        nextRound();
    }

    setCurrentTurnIndex(nextIndex);

    if (nextIndex != -1) {
        emit turnChanged(m_characters.at(nextIndex)->name());
    }
}

void CharacterModel::previousTurn()
{
    if (m_characters.isEmpty())
        return;

    int prevIndex = getPreviousActiveCharacterIndex(m_currentTurnIndex);
    setCurrentTurnIndex(prevIndex);

    if (prevIndex != -1) {
        emit turnChanged(m_characters.at(prevIndex)->name());
    }
}

void CharacterModel::resetTurn()
{
    setCurrentTurnIndex(-1);
    setRoundNumber(1);
}

QString CharacterModel::getCurrentCharacterName() const
{
    if (m_currentTurnIndex >= 0 && m_currentTurnIndex < m_characters.size()) {
        return m_characters.at(m_currentTurnIndex)->name();
    }
    return "No active character";
}


void CharacterModel::nextRound()
{
    setRoundNumber(m_roundNumber + 1);
    emit roundChanged(m_roundNumber);
}

void CharacterModel::resetRound()
{
    setRoundNumber(1);
}


void CharacterModel::applyDamage(int index, int damage)
{
    if (index < 0 || index >= m_characters.size())
        return;

    Character* character = m_characters.at(index);
    int newHealth = character->health() - damage;
    character->setHealth(newHealth);


    if (newHealth <= 0 && character->isActive()) {
        character->setIsActive(false);
    }
}

void CharacterModel::applyHealing(int index, int healing)
{
    if (index < 0 || index >= m_characters.size())
        return;

    Character* character = m_characters.at(index);
    int newHealth = character->health() + healing;
    character->setHealth(newHealth);


    if (newHealth > 0 && !character->isActive()) {
        character->setIsActive(true);
    }
}


void CharacterModel::autoSave()
{
    QString appDataPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QDir().mkpath(appDataPath);
    QString filePath = appDataPath + "/autosave.btl";

    QJsonDocument doc;
    QJsonObject root;
    QJsonArray charactersArray;

    for (Character* character : m_characters) {
        charactersArray.append(character->toJson());
    }

    root["characters"] = charactersArray;
    root["currentTurnIndex"] = m_currentTurnIndex;
    root["roundNumber"] = m_roundNumber;
    doc.setObject(root);

    QFile file(filePath);
    if (file.open(QIODevice::WriteOnly)) {
        file.write(doc.toJson());
        file.close();
        qDebug() << "Auto-saved to:" << filePath;
    }
}

void CharacterModel::autoLoad()
{
    QString appDataPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QString filePath = appDataPath + "/autosave.btl";

    QFile file(filePath);
    if (!file.exists() || !file.open(QIODevice::ReadOnly)) {
        return;
    }

    QByteArray data = file.readAll();
    file.close();

    QJsonDocument doc = QJsonDocument::fromJson(data);
    if (!doc.isObject()) {
        return;
    }

    QJsonObject root = doc.object();


    clearAll();


    QJsonArray charactersArray = root["characters"].toArray();
    for (const QJsonValue& value : charactersArray) {
        if (value.isObject()) {
            Character* character = new Character(this);
            character->fromJson(value.toObject());

            beginInsertRows(QModelIndex(), m_characters.size(), m_characters.size());
            connectCharacterSignals(character);
            m_characters.append(character);
            endInsertRows();
        }
    }


    setCurrentTurnIndex(root["currentTurnIndex"].toInt(-1));
    setRoundNumber(root["roundNumber"].toInt(1));

    sortByInitiative();
    qDebug() << "Auto-loaded from:" << filePath;
}


void CharacterModel::setCurrentTurnIndex(int index)
{
    if (index != m_currentTurnIndex) {
        int oldIndex = m_currentTurnIndex;
        m_currentTurnIndex = index;


        if (oldIndex >= 0 && oldIndex < m_characters.size()) {
            QModelIndex modelIndex = createIndex(oldIndex, 0);
            emit dataChanged(modelIndex, modelIndex, {IsCurrentTurnRole});
        }

        if (m_currentTurnIndex >= 0 && m_currentTurnIndex < m_characters.size()) {
            QModelIndex modelIndex = createIndex(m_currentTurnIndex, 0);
            emit dataChanged(modelIndex, modelIndex, {IsCurrentTurnRole});
        }

        emit currentTurnIndexChanged();
    }
}

void CharacterModel::setRoundNumber(int round)
{
    if (round != m_roundNumber) {
        m_roundNumber = round;
        emit roundNumberChanged();
    }
}


int CharacterModel::getNextActiveCharacterIndex(int startIndex) const
{
    if (m_characters.isEmpty())
        return -1;

    int start = (startIndex + 1) % m_characters.size();


    if (startIndex == -1) {
        start = 0;
    }

    for (int i = 0; i < m_characters.size(); ++i) {
        int index = (start + i) % m_characters.size();
        if (m_characters.at(index)->isActive()) {
            return index;
        }
    }

    return -1;
}

int CharacterModel::getPreviousActiveCharacterIndex(int startIndex) const
{
    if (m_characters.isEmpty())
        return -1;

    int start = startIndex - 1;
    if (start < 0) {
        start = m_characters.size() - 1;
    }

    for (int i = 0; i < m_characters.size(); ++i) {
        int index = (start - i + m_characters.size()) % m_characters.size();
        if (m_characters.at(index)->isActive()) {
            return index;
        }
    }

    return -1;
}
