import QtQuick 2.12
import QtQuick.Layouts 1.15

Rectangle {
    id: footer
    color: footerCSS.background
    height: footerCSS.height
    Rectangle{
        id: footer__border
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 20
        width: parent.width-40;
        height:1
        color: theme.text
    }
    
    // Image {
    //     id: rp2
    //     width: 36
    //     fillMode: Image.PreserveAspectFit
    //     source: "../assets/icons/"+ theme.footer_icon
    //     asynchronous: true        
    //     anchors.top: parent.top
    //     anchors.left: parent.left
    //     anchors.leftMargin: 42
    //     anchors.topMargin: 14
    // }      

    RowLayout {
        layoutDirection: Qt.RightToLeft
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10*screenRatio
        spacing: 5*screenRatio

        LegendButton {
            buttonName: "B"
            buttonText: "Back"
        }

        LegendButton {
            buttonName: "A"
            buttonText: currentPage === 'HomePage' ? "Open" : "Play"
        }

        LegendButton {
            buttonName: "Y"
            buttonText: "Favorite"
            visible: currentPage !== "HomePage" ? 1 : 0
        }

        LegendButton {
            buttonName: "X"
            buttonText: "Details"
            visible: currentPage === "ListPage" ? 1 : 0
        }

        LegendButton {
            buttonName: "R1"
            buttonText: "Next"
            visible: currentPage !== "HomePage" ? 1 : 0
        }

        LegendButton {
            buttonName: "L1"
            buttonText: "Prev"
            visible: currentPage !== "HomePage" ? 1 : 0
        }

    }        
}    
