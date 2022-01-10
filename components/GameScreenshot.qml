import QtQuick 2.12
import QtGraphicalEffects 1.12
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.15
import QtMultimedia 5.15

Item {
    id: gameScreenshot
    width: parent.width
    height: parent.height

    property var game: null
    property var active: false

    property var screenshot: {
        if(!game) {return ""}
        return game.assets.screenshot
    }
    property var video: {
        if(!game) {return ""}
        return game.assets.video
    }

    Timer {
        id: timer
        running: false
        repeat: false
        interval: 5000

        onTriggered: {
            if(video && active) {
                videoPlayer.play()
            }
        }
    }

    onGameChanged: {
        videoPlayer.stop()
        timer.stop()
        videoRect.opacity = 0
        timer.start()
    }

    onActiveChanged: {
        if (video && active) {
            videoPlayer.stop()
            timer.stop()
            videoRect.opacity = 0
            timer.start()
        } else {
            videoPlayer.stop()
            timer.stop()
            videoRect.opacity = 0
        }
    }

    Image {
        source: screenshot
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        opacity: 1
    }

    Rectangle {
        id: videoRect
        anchors.fill: parent
        color: theme.sidebarBackground
        opacity: 0
        Video {
            id: videoPlayer
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: video
            autoLoad: true
            autoPlay: false
            loops: MediaPlayer.Infinite 
           

            onPlaying: {
                videoAnimator.running = true;
            }
        }
        OpacityAnimator {
            id: videoAnimator;
            target: videoRect;
            from: 0;
            to: 1;
            duration: 2000
            running: false
        }
   }

}