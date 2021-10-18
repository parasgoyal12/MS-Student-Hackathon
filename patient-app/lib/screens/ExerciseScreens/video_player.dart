import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:treatment_checkup_app/models/exercise.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart' as new_video;
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as old_video;
class VideoPlayer extends StatefulWidget {
  final Exercise exercise;
  VideoPlayer({this.exercise});

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
new_video.YoutubePlayerController _controller;
 void runYoutubePlayer(){
   _controller=new_video.YoutubePlayerController(
       initialVideoId: YoutubePlayer.convertUrlToId(widget.exercise.url),
       params: new_video.YoutubePlayerParams(
        // playlist: ['nPt8bK2gbaU', 'gQDByCdjUXw'], // Defining custom playlist
        //  startAt: Duration(seconds: 30),
         showControls: true,
         showFullscreenButton: true,
         autoPlay: false,
         loop: true,
         privacyEnhanced: true,


       )

//        initialVideoId: YoutubePlayer.convertUrlToId(widget.exercise.url));
// flags:YoutubePlayerFlags(
//      controlsVisibleAtStart: true,
//      loop: true,
//
//      enableCaption: false,
//      isLive: false,
//      autoPlay: false,
   );
   _controller.onEnterFullscreen = () {
     SystemChrome.setPreferredOrientations([
       DeviceOrientation.landscapeLeft,
       DeviceOrientation.landscapeRight,
     ]);

    // log('Entered Fullscreen');
   };
 }
  @override
 void initState(){
   runYoutubePlayer();
   super.initState();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    _controller.pause();
    super.deactivate();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.close();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
        return Scaffold(
          body:  Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                   new_video.YoutubePlayerIFrame(
                     controller: _controller,

                     //showControls:true,
                     // showVideoProgressIndicator: true, progressIndicatorColor: Colors.white,
                        aspectRatio: 16/9,
                       ),

                    Positioned(
                      top: 40,
                      right: 20,
                      child: Column(
                        children: [
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(0, 0, 0, 0.7),
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                // Container(
                //   padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
                //   height: size.height - 270.0,
                //   width: size.width,
                //   color: Colors.white,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: <Widget>[
                //       Column(
                //         children: <Widget>[
                //           Padding(
                //             padding: const EdgeInsets.only(bottom: 15.0),
                //             child: Text(
                //               '',
                //               style: TextStyle(
                //                 fontSize: 28.0,
                //                 fontWeight: FontWeight.w900,
                //                 color: Colors.grey[700],
                //               ),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(bottom: 20.0),
                //             child: Text(
                //               'Follow the video in real time',
                //               style: TextStyle(
                //                 fontSize: 20.0,
                //                 fontWeight: FontWeight.w900,
                //                 color: Colors.grey[300],
                //               ),
                //             ),
                //           ),
                //
                //         ],
                //       ),
                //
                //     ],
                //   ),
                // ),
              ],
            ),

        );



  }
}
