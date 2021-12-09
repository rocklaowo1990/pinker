// 视频展示
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinker/values/values.dart';

import 'package:pinker/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

Widget getVideoBox(VideoPlayerController videoPlayerController) {
  return getButton(
      onPressed: () {
        videoPlayerController.play();
      },
      background: Colors.transparent,
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(
            color: AppColors.inputFiled,
            borderRadius: BorderRadius.all(Radius.circular(4.w))),
        child: Center(
          child: FutureBuilder(
            future: videoPlayerController.initialize(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                return AspectRatio(
                  aspectRatio: videoPlayerController.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(videoPlayerController),
                );
              } else {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ));
}
