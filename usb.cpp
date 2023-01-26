#include "usb.h"
#include <QDebug>
QString syskernel;//系统架构
QProcess *process = new QProcess();
QTemporaryFile tempFile;
QTemporaryFile tempFile1;
QTemporaryFile tempFile2;
QString usbclass;


QString usbinstall;//格式化选项
int udisk;






usb::usb(QObject *parent)
    : QObject{parent}
{
    tempFile.open();
    tempFile.write("list disk");
    tempFile.close();
    tempFile2.open();
    tempFile2.write("select volume I"+QString("\n").toLocal8Bit()+"remove letter I");
    tempFile2.close();

}



Q_INVOKABLE QString usb::sys(){
    QString sysVersion;//系统版本
    QString system;//获取结果
    sysVersion = QSysInfo::productVersion();
    syskernel = QSysInfo::currentCpuArchitecture();
    system = sysVersion +"&"+ syskernel;
    return system;//返回版本
    qDebug()<<sysVersion;
    qDebug()<<syskernel;
}



Q_INVOKABLE QStringList usb::usbrun(){
//    list1.clear();
//    QList<QStorageInfo> devices = QStorageInfo::mountedVolumes();
//    QString path;
//    QString root;
//    qint64 capacity;
//    QString result;
//    for(const QStorageInfo &storages :devices ){
//        path = storages.name();
//        root = storages.rootPath();
//        capacity = storages.bytesTotal()/(1024*1024*1024);
//        qDebug()<<capacity;
//        result = root +" "+path;
//        list1<<result+" "+QString::number(capacity)+"GB";
//    }
//    qDebug()<<list1;
//    return list1;


    process->start("cmd",QStringList()<<"/c"<<"diskpart /s "+tempFile.fileName());//先执行cmd开启，再执行后面的

    process->waitForFinished();
    QTextStream stream(process->readAllStandardOutput());
//     stream.setCodec("GBK");
    //qDebug().noquote() << stream.readAll();
    QString line;
    QString lines;
    list1.clear();
    while (stream.readLineInto(&line))
   {
        if(line.contains("GB")){
             qDebug() << line;
                if (line.startsWith("  磁盘")) {
                     QStringList parts = line.split(" ");//以空格为分割，一个空格占一个元素，不是空格的合在一起算一个元素
                     qDebug()<<parts;
                     QString disk = parts.at(3);//算的时候从第0开始算
                     QString size = parts.at(21);
                     QString unit = parts.at(22);
                    lines = "磁盘:" + disk +" "+ "大小:" + size + unit;//chcp更改会报错
                    list1<<lines;
             }

        }

    }

    return list1;
}
Q_INVOKABLE int usb::usbdisk(int a,QString uinstall){//传递qml中选择U盘的序号
    udisk = a;
    qDebug()<<udisk;
    usbinstall = uinstall;
     qDebug()<<usbinstall;
    return 0;
}
Q_INVOKABLE void usb::usbClean(){
    //每次初始化会更改临时文件的配置
        tempFile1.open();
        tempFile1.write("select disk "+QString::number(udisk).toLocal8Bit()+"\n"+"clean"+"\n"+
                        "create partition primary size=2048"+"\n"+"format fs="+usbinstall.toLocal8Bit()+" label=EFI quick"+
                        "\n"+"ASSIGN letter=i"+"\n"+"create partition primary"+"\n"+"format fs=NTFS quick"+"\n"
                        +"ASSIGN");
        tempFile1.close();


        process->start("cmd",QStringList()<<"/c"<<"diskpart /s "+tempFile1.fileName());
        process->waitForFinished();
        process->close();
//        QTextStream stream1(process->readAllStandardOutput());
//        stream1.setCodec("GBK");
//        qDebug().noquote() << stream1.readAll();

}
Q_INVOKABLE int usb::usbBrush(int uclass){

    if(uclass == 0){
        process->start("cmd",QStringList()<<"/c"<<"7z.exe x -oI: ./DawnPE_V1.1.8.iso");
        process->waitForFinished();
        qDebug()<<process->readAllStandardOutput();
        process->close();
    }else if(uclass == 1){
        process->start("cmd",QStringList()<<"/c"<<"7z.exe x -oI: ./DawnPE_V1.1.8.iso");
        process->waitForFinished();
        process->close();
        process->start("cmd",QStringList()<<"/c"<<"diskpart /s "+tempFile2.fileName());
        process->waitForFinished();
        process->close();
    }


    return 0;
}
