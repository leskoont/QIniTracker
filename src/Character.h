#ifndef CHARACTER_H
#define CHARACTER_H

#include <QString>
#include <QObject>
#include <QJsonObject>

class Character : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(int level READ level WRITE setLevel NOTIFY levelChanged)
    Q_PROPERTY(int health READ health WRITE setHealth NOTIFY healthChanged)
    Q_PROPERTY(int armor READ armor WRITE setArmor NOTIFY armorChanged)
    Q_PROPERTY(int initiative READ initiative WRITE setInitiative NOTIFY initiativeChanged)
    Q_PROPERTY(bool isActive READ isActive WRITE setIsActive NOTIFY isActiveChanged)
    Q_PROPERTY(bool isEnemy READ isEnemy WRITE setIsEnemy NOTIFY isEnemyChanged)
    Q_PROPERTY(QString statuses READ statuses WRITE setStatuses NOTIFY statusesChanged)
    Q_PROPERTY(QString notes READ notes WRITE setNotes NOTIFY notesChanged)

public:
    explicit Character(QObject *parent = nullptr);
    Character(const QString &name, int level, int health, int armor, int initiative,
              bool isActive = true, bool isEnemy = false, const QString &statuses = "",
              const QString &notes = "", QObject *parent = nullptr);


    QString name() const { return m_name; }
    int level() const { return m_level; }
    int health() const { return m_health; }
    int armor() const { return m_armor; }
    int initiative() const { return m_initiative; }
    bool isActive() const { return m_isActive; }
    bool isEnemy() const { return m_isEnemy; }
    QString statuses() const { return m_statuses; }
    QString notes() const { return m_notes; }


    void setName(const QString &name);
    void setLevel(int level);
    void setHealth(int health);
    void setArmor(int armor);
    void setInitiative(int initiative);
    void setIsActive(bool isActive);
    void setIsEnemy(bool isEnemy);
    void setStatuses(const QString &statuses);
    void setNotes(const QString &notes);


    QJsonObject toJson() const;
    void fromJson(const QJsonObject &json);


    QString statusText() const { return m_isActive ? "Active" : "Eliminated"; }
    QString typeText() const { return m_isEnemy ? "Enemy" : "Friend"; }

signals:
    void nameChanged();
    void levelChanged();
    void healthChanged();
    void armorChanged();
    void initiativeChanged();
    void isActiveChanged();
    void isEnemyChanged();
    void statusesChanged();
    void notesChanged();

private:
    QString m_name;
    int m_level;
    int m_health;
    int m_armor;
    int m_initiative;
    bool m_isActive;
    bool m_isEnemy;
    QString m_statuses;
    QString m_notes;
};

#endif
