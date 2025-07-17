#include "Character.h"
#include <QJsonObject>

Character::Character(QObject *parent)
    : QObject(parent)
    , m_name("New Character")
    , m_level(0)
    , m_health(0)
    , m_armor(0)
    , m_initiative(0)
    , m_isActive(true)
    , m_isEnemy(false)
    , m_statuses("")
    , m_notes("")
{
}

Character::Character(const QString &name, int level, int health, int armor, int initiative,
                     bool isActive, bool isEnemy, const QString &statuses,
                     const QString &notes, QObject *parent)
    : QObject(parent)
    , m_name(name)
    , m_level(level)
    , m_health(health)
    , m_armor(armor)
    , m_initiative(initiative)
    , m_isActive(isActive)
    , m_isEnemy(isEnemy)
    , m_statuses(statuses)
    , m_notes(notes)
{
}

void Character::setName(const QString &name)
{
    if (m_name != name) {
        m_name = name;
        emit nameChanged();
    }
}

void Character::setLevel(int level)
{
    if (m_level != level) {
        m_level = level;
        emit levelChanged();
    }
}

void Character::setHealth(int health)
{
    if (m_health != health) {
        m_health = health;
        emit healthChanged();
    }
}

void Character::setArmor(int armor)
{
    if (m_armor != armor) {
        m_armor = armor;
        emit armorChanged();
    }
}

void Character::setInitiative(int initiative)
{
    if (m_initiative != initiative) {
        m_initiative = initiative;
        emit initiativeChanged();
    }
}

void Character::setIsActive(bool isActive)
{
    if (m_isActive != isActive) {
        m_isActive = isActive;
        emit isActiveChanged();
    }
}

void Character::setIsEnemy(bool isEnemy)
{
    if (m_isEnemy != isEnemy) {
        m_isEnemy = isEnemy;
        emit isEnemyChanged();
    }
}

void Character::setStatuses(const QString &statuses)
{
    if (m_statuses != statuses) {
        m_statuses = statuses;
        emit statusesChanged();
    }
}

void Character::setNotes(const QString &notes)
{
    if (m_notes != notes) {
        m_notes = notes;
        emit notesChanged();
    }
}

QJsonObject Character::toJson() const
{
    QJsonObject json;
    json["name"] = m_name;
    json["level"] = m_level;
    json["health"] = m_health;
    json["armor"] = m_armor;
    json["initiative"] = m_initiative;
    json["isActive"] = m_isActive;
    json["isEnemy"] = m_isEnemy;
    json["statuses"] = m_statuses;
    json["notes"] = m_notes;
    return json;
}

void Character::fromJson(const QJsonObject &json)
{
    setName(json["name"].toString("New Character"));
    setLevel(json["level"].toInt(0));
    setHealth(json["health"].toInt(0));
    setArmor(json["armor"].toInt(0));
    setInitiative(json["initiative"].toInt(0));
    setIsActive(json["isActive"].toBool(true));
    setIsEnemy(json["isEnemy"].toBool(false));
    setStatuses(json["statuses"].toString(""));
    setNotes(json["notes"].toString(""));
}
