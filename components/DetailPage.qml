import QtQuick 2.12
import QtQuick.Layouts 1.15

Item {
    id: detailpage

    property var game: null
    onGameChanged: {
        console.log('OnGameChanged:' + game.title)
        textScroll = 0;
    }

    property var mainGenre: {
        if (game.genreList.lenght == 0){
            return null 
        }
        var g = game.genreList[0]
        var s = g.split(', ')
        return s[0]
    }

    property var players: {
        if (!game){ return null }
        if (game.players > 0) {
            return game.players + " Player" + (game.players > 1 ? "s": "")
        } else {
            return null
        }
    }

    property var playerGenre: {
        return [players, mainGenre].filter(v => { return v != null }).join(" • ")
    }

    property var releaseDateDeveloper: {
        return [releaseDate, developedBy].filter(v => { return v != "" }).join(" • ")
    }

    property var releaseDate: {
        if (!game){ return "" }
        return (game.releaseYear)? "Released " + game.releaseYear: ""
    }

    property var developedBy: {
        if (!game){ return "" }
        return "Developed By " + game.developer
    }

    property var margin: {
        return 10
    }

    property var textScroll: 0

    property var scrollMoveAmount : 100


    Rectangle {
        id: detailsWrapper
        color: "transparent"
        width: wrapperCSS.width
        height: wrapperCSS.height - footerCSS.height
        focus: currentPage === 'DetailPage' ? true: false ;

        Keys.onDownPressed: {
            var maxHeight =  textElement.paintedHeight - background.height
            console.log('max height ' + maxHeight)
            console.log('background height ' + background.height)

            textScroll = Math.max(Math.min(textScroll + scrollMoveAmount, maxHeight), 0)
        }

        Keys.onUpPressed: {
            textScroll = Math.max(textScroll - scrollMoveAmount, 0)
        }

        Keys.onPressed: {

            console.log('got a key: ' + event);

            //Back to List. It's up here so when a list has no games you can still go back to the home
            if (api.keys.isCancel(event)) {
                event.accepted = true;
                console.log('exit details');
                navigate('ListPage');
                return;
            }

            if (api.keys.isFilters(event)) {
                event.accepted = true;
                console.log('Favorite');
                favSound.play()
                game.favorite = !game.favorite
                return;
            }

            //Next collection
            if (api.keys.isNextPage(event)) {
                event.accepted = true;
                console.log('Next game');
                
                console.log('Old currentGameIndex ' + currentGameIndex);
                console.log('currentCollection.games.count ' + currentCollection.games.count);
                if (currentGameIndex < currentCollection.games.count - 1) {
                    currentGameIndex++
                } else {
                    currentGameIndex = 0;
                }
                console.log('New currentGameIndex ' + currentGameIndex);
                return;
            }  
            
            //Prev collection
            if (api.keys.isPrevPage(event)) {
                event.accepted = true;
                console.log('Prev game');
                if (currentGameIndex > 0) {
                    currentGameIndex--
                } else {
                    currentGameIndex = currentCollection.games.count - 1
                }
                navigate('DetailPage');
                return;
            }  

        }

        Rectangle {
            id: sidebar
            color: theme.sidebarBackground
            width: 260
            height: wrapperCSS.height
            opacity: 1.0

            Rectangle {
                color: "transparent"
                height:170
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.bottomMargin: 10
                anchors.leftMargin: 10
                anchors.rightMargin: 10

                GameScreenshot {
                    anchors.fill: parent
                    game: currentGame
                    active: currentPage === 'DetailPage' ? true: false ;
                }

            }

            Rectangle {
                color: "transparent"
                height:250
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.rightMargin: 10

                Image {
                    id: boxart
                    source: game.assets.boxFront 
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                }
            }

        }

        Rectangle {
            id: gamedetails
            color: "transparent"
            height: wrapperCSS.height - footerCSS.height - margin * 2
            anchors.left: sidebar.right
            anchors.top: detailsWrapper.top
            anchors.right: detailsWrapper.right

        }

        Rectangle {
            id: gamedetailstext
            color: "transparent"
            anchors.left: sidebar.right
            anchors.top: gamedetails.top
            anchors.right: gamedetails.right
            anchors.leftMargin: margin
            anchors.topMargin: margin
            anchors.rightMargin: margin
            height: wrapperCSS.height - footerCSS.height - margin * 4

            Text {
                id: titleText
                text: game.title
                lineHeight: 1.2
                color: theme.title
                font.pixelSize: 22
                font.letterSpacing: -0.35
                width: parent.width
                wrapMode: Text.WordWrap
                maximumLineCount: 2
                elide: Text.ElideRight
            }

            Text {
                id: playerGenreText
                anchors.top: titleText.bottom
                text: playerGenre
                color: theme.text
                font.pixelSize: 14
                font.letterSpacing: -0.35
                wrapMode: Text.WordWrap
                width: parent.width
                maximumLineCount: 4
            }

            Text {
                id:releaseDateDeveloperText
                anchors.top: playerGenreText.bottom
                text: releaseDateDeveloper
                color: theme.text
                font.pixelSize: 14
                font.letterSpacing: -0.35
            }

            Item {  
                anchors.top: releaseDateDeveloperText.bottom
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                Rectangle {
                    id: background
                    color: "transparent"
                    anchors.fill: parent
                    opacity: 1.0
                    clip: true

                    Text {
                        id: textElement
                        text: game.description
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top            
                        anchors.topMargin: 0 - textScroll
                        font.pixelSize: 16
                        font.letterSpacing: -0.35
                        color: theme.text
                        wrapMode: Text.WordWrap
                        maximumLineCount: 2000
                        lineHeight: 1.2

                        Behavior on anchors.topMargin {
                            PropertyAnimation { easing.type: Easing.OutCubic; duration: 200  }
                        }                
                    }
                }
            }
        }

        Footer {
            id: detailfooter
            anchors.left: sidebar.right
            anchors.top: detailsWrapper.bottom
            anchors.right: detailsWrapper.right
        }
    }



    Canvas {
        id: game__is_fav
        // canvas size
        width: 60; height: 60;
        opacity: 0.8
        visible: game.favorite
        // handler to override for drawing
        onPaint: {
            // get context to draw with
            var ctx = getContext("2d")
            var gradient = ctx.createLinearGradient(100, 0, 100, 200)
            gradient.addColorStop(0, "#b12c19")
            // setup the fill
            ctx.fillStyle = gradient
            // ctx.fillRect(50, 50, 100, 100)
            // begin a new path to draw
            ctx.beginPath()
            // top-left start point
            ctx.moveTo(0, 0)
            // upper line
            ctx.lineTo(60, 0)
            // right line
            ctx.lineTo(0, 60)
            // bottom line
            ctx.lineTo(0, 0)
            // left line through path closing
            ctx.closePath()
            // fill using fill style
            ctx.fill()
        }
        Image {
            width: 24
            fillMode: Image.PreserveAspectFit
            source: "../assets/icons/heart_solid.svg"
            asynchronous: true

            anchors {
                left: parent.left;
                top: parent.top;
            }
            anchors.leftMargin: 6
            anchors.topMargin: 6
        }

    }
}
