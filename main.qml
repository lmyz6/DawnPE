import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.5
import MyNameSpace 1.0



Window {
    MyClass{
        id:sysv
    }

    visible: true
    title: "DawnPE1.2.0"
    //设置固定窗口
    minimumWidth:640
    minimumHeight:400
    maximumWidth:640
    maximumHeight:400

    //顶层设计
    property int bclick: 0

    Item {
        id:wintop
        width:parent.width
        height:settings.height

//        color: "yellow"
        //设置按钮
        Button {
            id:settings
            highlighted: true//主题高亮
            flat: true//看起来透明

            Material.accent: Material.Blue

            icon {
                source: "./icon/settings.svg"
            }



            onClicked: {
                if(bclick == 0){
                    siderbar.open()
                    bclick = 1
                 }else if(bclick == 1){
                    siderbar.close()
                    bclick = 0
                }

              }


        }


            Label {
                    id:syslabel
                    height: 5
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Windows: "
                    anchors.right: version.left


                }
                Label{
                    id:version
                    height: 5
                    anchors.verticalCenter: parent.verticalCenter//垂直居中
                    anchors.right: wintop.right
                    text: sysv.sys();
                }



    }//顶部结束
    Drawer {
       id: siderbar
       width: 100
       height: parent.height-settings.height
       topMargin: settings.height
       position: Drawer.Left
       Column{
           Button{
               id:home
               text:"首页"
               width:siderbar.width
               highlighted: true
               flat: true
               Material.accent: Material.Blue
               onClicked: {
                   pageLoader.source = "./page1.qml";
                   siderbar.close()
                }
           }
           Button{
               id:start1
               text:"开始"
               width:siderbar.width
               highlighted: true
               flat: true
               Material.accent: Material.Blue
               onClicked:{
                   pageLoader.source ="./page2.qml"
                   siderbar.close()

                 }
           }
           Button{
               id:iso
               text:"镜像下载"
               width:siderbar.width
               highlighted: true
               flat: true
               Material.accent: Material.Blue
               onClicked:{
                   pageLoader.source="./page3.qml"
                   siderbar.close()

                 }

           }
           Button{
               id:about
               text:"关于"
               width:siderbar.width
               highlighted: true
               flat: true
               Material.accent: Material.Blue
               onClicked:{
                   pageLoader.source="./page4.qml"
                   siderbar.close()

                }
           }
       }

    }
    StackView{
        anchors.top: wintop.bottom
        width: parent.width
        height: parent.height-wintop.height
        Loader{
            id:pageLoader
        }
    }




}

