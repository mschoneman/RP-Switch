import QtQuick 2.12
import QtQuick.Layouts 1.15

    RowLayout {
        property var buttonName: null
        property var buttonText: null

        height: parent.height

        Rectangle{
            height:20*screenRatio
            width:20*screenRatio
            color:"#444"
            radius:20*screenRatio
            Layout.alignment: Qt.AlignVCenter

            Text{
                text: buttonName
                color:"white"                    
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 12*screenRatio
            }
        }

                    
        Text{
            text: buttonText
            color: theme.text                       
            Layout.alignment: Qt.AlignVCenter
            font.pixelSize: 10*screenRatio
        }
    }
