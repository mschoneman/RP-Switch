import QtQuick 2.12
import QtQuick.Layouts 1.15

    RowLayout {
        property var buttonName: null
        property var buttonText: null

        height: parent.height
        anchors.verticalCenter: parent.verticalCenter

        Rectangle{
            height:20*screenRatio
            width:20*screenRatio
            color:"#444"
            radius:20*screenRatio
            anchors.verticalCenter: parent.verticalCenter

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
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 10*screenRatio
        }
    }
