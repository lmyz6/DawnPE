import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.5
import MyNameSpace 1.0
Item {
    MyClass{
        id:usbobject
    }

    property int uclasses: 0
    property int uinstall: 0

    Button{

        flat: true
        highlighted: true
        Material.accent: Material.LightBlue
        y:box.y
        anchors.right: box.left
        icon{
            source: "./icon/refresh.svg"
        }
        onClicked: {
            box.model = usbobject.usbrun()

        }
    }

    ComboBox{

        Material.accent: Material.LightBlue
        id:box
        width:300
        x:140
        y:120
        model:usbobject.usbrun()

    }
    Button{
        x:box.x+box.width+3
        y:box.y
        highlighted: true

        Material.accent: Material.BlueGrey
        text:"一键刷入"
        onClicked: {
            brush.open()
        }

    }
    Dialog{
      title: "请选择刷入方案(除免格升级都会格式化U盘)"
      width: 600
      height:200
      id:brush
        ComboBox{
            id:usbOptions
            width:300
            model: ["正常模式","隐藏模式(看不见PE目录)"]

        }
        ComboBox{
            id:usbInstall
            width:200
            Material.accent: Material.Blue
            anchors.left: usbOptions.right
            model:["exFAT","NTFS","FAT32"]
        }
        Button{
            anchors.top: usbOptions.bottom
            text: "开始刷入"

            highlighted: true
            Material.accent: Material.Red
            onClicked: {
                uclasses = usbOptions.currentIndex//用户选择的方案
                sta.open()//打开状态窗口
                usbobject.usbdisk(box.currentIndex,usbInstall.displayText);//  磁盘/格式化格式

                usbobject.usbClean();//执行指令

                status.text = "正在刷入..."
                usbobject.usbBrush(uclasses)
                status.text = "完成"

            }
        }

    }
    Dialog{
        id:sta
        Text {
            id:status
            color: "red"
            text: "正在格式化你的移动设备（U盘/移动硬盘）"
        }
    }



}
