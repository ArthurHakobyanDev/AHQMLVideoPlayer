#ifndef RUNCPP_H
#define RUNCPP_H

#include <QObject>
#include <QWidget>

class runcpp : public QObject
{
    Q_OBJECT
public:
    explicit runcpp(QObject *parent = nullptr);

signals:
public slots:
    QString runCPP();
    void callLock();
    void callUnlock();

};

#endif // RUNCPP_H
