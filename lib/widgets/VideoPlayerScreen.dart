import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:subtitle_wrapper_package/subtitle_wrapper_package.dart';
import 'package:subtitle_wrapper_package/subtitle_controller.dart';
import 'package:subtitle_wrapper_package/models/style/subtitle_style.dart';

class VideoPlayerScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen>{
  var videoPlayerController;
  var chewieController;
  var playerWidget;
  File video;
  String subtitlePath;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    video = File("/storage/emulated/0/documents/power.mkv");
    subtitlePath = "http://192.168.43.47:3000/assets/images/power.vtt";//"file:///storage/emulated/0/documents/power.vtt";
    //print(File(subtitlePath).existsSync());


   videoPlayerController = VideoPlayerController./*network("http://192.168.43.47:3000/assets/images/power.mkv");*/file(video);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
              elevation: 5.0,
              child: SubTitleWrapper(
                  videoPlayerController: videoPlayerController,
                  subtitleController: SubtitleController(
                    subtitleUrl: subtitlePath,
                    showSubtitles: true,
                  ),
                  subtitleStyle: SubtitleStyle(textColor: Colors.white, hasBorder: true),
                  videoChild: Chewie(
                    controller: chewieController,
                  ))),
        )
      )
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

}


/*class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  File file;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    file = File('sdcard/documents/power.mkv');
    print(file.existsSync());
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different coFile('sdcard/documents/power.mkv')nstructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}*/