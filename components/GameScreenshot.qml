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
        if(!game) {return null}
        return game.assets.screenshot
    }
    property var video: {
        if(!game) {return null}
        return game.assets.video
        return null
    }

    Timer {
        id: timer
        running: false
        repeat: false
        interval: 7000

        onTriggered: {
            if(video && active) {
                videoPlayer.play()
            }
        }
    }

    onGameChanged: {
        videoPlayer.stop()
        timer.stop()
        timer.start()
    }

    onActiveChanged: {
        if (video && active) {
            videoPlayer.stop()
            timer.stop()
            timer.start()
        } else {
            videoPlayer.stop()
            timer.stop()
        }
    }

    Image {
        source: screenshot
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        visible: videoPlayer.playbackState != MediaPlayer.PlayingState
    }

    Video {
        id: videoPlayer
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        source: video
        autoLoad: true
        autoPlay: false
        loops: MediaPlayer.Infinite 
        visible: videoPlayer.playbackState == MediaPlayer.PlayingState
    }

}