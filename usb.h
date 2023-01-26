#ifndef USB_H
#define USB_H

#include <QObject>
#include <QMetaObject>
#include <QQmlProperty>

#include <QStringList>
#include <QStringListModel>
#include <QList>
#include <QTemporaryFile>
#include <QTextStream>

//#include <QStorageInfo>
//#include <QSysInfo>
#include <QProcess>
#include <QFile>
#include <QIODevice>

class usb : public QObject
{
    Q_OBJECT

public:
    explicit usb(QObject *parent = nullptr);

    Q_INVOKABLE QString sys();

    Q_INVOKABLE QStringList usbrun();

    Q_INVOKABLE int usbdisk(int a,QString uinstall);
    Q_INVOKABLE void usbClean();

    Q_INVOKABLE int usbBrush(int uclass);



signals:


private:
    QStringList list1;



};

#endif // USB_H
