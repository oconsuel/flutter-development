import 'package:flutter/material.dart';
import 'package:lab_1/labs/SecondLab/video_items.dart';
import 'package:video_player/video_player.dart';
import 'package:lab_1/utils/themes.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          VideoItems(
            videoPlayerController: VideoPlayerController.asset(
              "assets/videos/sample.avi",
            ),
            looping: true,
            autoplay: false,
          ),
          VideoItems(
            videoPlayerController: VideoPlayerController.network(
              'https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4',
            ),
            looping: false,
            autoplay: true,
          ),
          VideoItems(
            videoPlayerController: VideoPlayerController.network(
              "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
            ),
            autoplay: false,
          ),
          VideoItems(
            videoPlayerController: VideoPlayerController.network(
                "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4"),
            looping: true,
            autoplay: false,
          ),
          VideoItems(
            videoPlayerController:
                VideoPlayerController.asset('assets/videos/Present_2.mp4'),
            looping: false,
            autoplay: true,
          ),
        ],
      ),
    );
  }
}
