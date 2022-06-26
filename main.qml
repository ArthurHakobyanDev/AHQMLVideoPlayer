import QtQuick
import QtQuick.Window 2.15
import QtMultimedia

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Arthur Hakobyan Video Player")



//Opens file dialog with CPP backend code instead of QuickDialogs module.
    Rectangle
    {
        id: button1
        width: 100; height: 20
        border.color: "black"
        border.width: 2
        property string vidSource;
        MouseArea{
            anchors.fill: parent
        onClicked: {
                button1.vidSource = qmlCPP.runCPP()
                video.play();
                video.volume = 0;
        }
        }
    }
    Text{
        x: 6
        y: 0
        text: "Select video file"
    }
//Pause/Play button
    Image{
        x: 304
        y: 410
        id: pausebutton
        source: "Pictures/pause.png"
        property int playState
        MouseArea{
            anchors.fill: parent
        onClicked: {
            if(video.playbackState == MediaPlayer.PlayingState)
            {
            pausebutton.playState = 1
            pausebutton.source = "Pictures/play.png"
            video.pause()
            }
            else
            {
             pausebutton.playState = 0
             pausebutton.source = "Pictures/pause.png"
             video.play()
            }
        }
        }
    }
//Slider line
    Rectangle{
        x: 70
        y: 455
        width: 500
        height: 5
        color: "black"

    }
//Slider
    Rectangle{
        id: slider
        x: 60
        y: 442
        width: 10
        height: 30
        color: "gray"
        property int pressed
//Updates video position as slider is moved. Limits slider movement to horizontal only and keeps it within the black line.
        function resetPosition(){
            if(slider.pressed != 0)
            {
            video.position = video.duration * ((slider.x-60)/500)
            }
            slider.y = 442
            if(slider.x < 60){
            slider.x = 60
        }
            else if(slider.x > 560)
            {
                slider.x = 560
            }
        }
        onXChanged: resetPosition()
        onYChanged: resetPosition()
        MouseArea{
//Pauses/plays the video on slider press/release respectively. Does not resume the video if pause button is pressed.
            anchors.fill: parent
            drag.target: parent
            onPressed:{
                slider.pressed = 1
                video.pause()

            }
            onReleased:{
                slider.pressed = 0
            if(pausebutton.playState != 1)
            {
                video.play()
            }

            }

        }

    }

//Video Player
    Video {
        id: video
        y: 25
        width : 640
        height : 380
        source: "file:///" +  button1.vidSource
//Calls screenlock while video is playing. Disables screenlock when video has stopped. Check cpp files and .mm file for screenlock code.
        onPositionChanged:{
            slider.x = 60 + ((video.position/video.duration) * 500)
            qmlCPP.callUnlock();
            if(video.playbackState == MediaPlayer.StoppedState)
            {
                qmlCPP.callLock();
            }

        }
    }




}
