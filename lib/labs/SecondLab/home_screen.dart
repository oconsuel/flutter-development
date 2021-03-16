import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          VideoItems(
            videoPlayerController: VideoPlayerController.network(
              'https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4',
            ),
            looping: true,
            autoplay: true,
          ),
          // VideoItems(
          //   videoPlayerController: VideoPlayerController.network(
          //     "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
          //   ),
          //   autoplay: false,
          // ),
          // VideoItems(
          //   videoPlayerController: VideoPlayerController.network(
          //       "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4"),
          //   looping: false,
          //   autoplay: false,
          // ),
        ],
      ),
    );
  }
}

class VideoItems extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final bool autoplay;

  VideoItems({
    @required this.videoPlayerController,
    this.looping,
    this.autoplay,
    Key key,
  }) : super(key: key);

  @override
  _VideoItemsState createState() => _VideoItemsState();
}

class _VideoItemsState extends State<VideoItems> {
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      autoInitialize: true,
      autoPlay: widget.autoplay,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        alignment: Alignment(1, 1),
        padding: const EdgeInsets.all(8.0),
        height: 400,
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Chewie(
    //     height: 100,
    //     controller: _chewieController,
    //   ),
    // );
  }
}
