#include "runcpp.h"
#include <QDebug>
#include <QFileDialog>

runcpp::runcpp(QObject *parent)
    : QObject{parent}
{

}

QString runcpp::runCPP()
{
QString filePath = QFileDialog::getOpenFileName();
return filePath;
}

void runcpp::callLock()
{

#if defined(Q_OS_IOS)
   ScreenLock::setDisabled(true);
#endif

}

void runcpp::callUnlock()
{

#if defined(Q_OS_IOS)
    ScreenLock::setDisabled(false);
#endif

}
