import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.5



Item {


    Text {
        id:welcome
        text: "欢迎使用DawnPE!(试运行)"
        font.pixelSize: 25
    }
    Button{
        anchors.top:welcome.bottom
        onClicked: {

        }
    }


}
