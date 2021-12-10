import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class MediaView {
  static Widget _backButton({
    PageController? pageController,
    VideoPlayerController? videoPlayerController,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, top: 24.w),
      child: getButton(
        height: 24.w,
        width: 24.w,
        background: Colors.black54,
        child: SvgPicture.asset('assets/svg/icon_back.svg'),
        onPressed: () {
          Get.back();
          if (videoPlayerController != null) videoPlayerController.dispose();
          if (pageController != null) pageController.dispose();
        },
      ),
    );
  }

  static Future<dynamic> imagePage(ListElement item, int index) {
    late List images;
    if (item.works.pics != null) {
      images = item.works.pics!;
    } else {
      images = item.works.video!.previewsUrls!;
    }
    final PageController pageController = PageController(initialPage: index);

    Widget child = PageView(
      controller: pageController,
      children: images
          .map((url) => Center(
                child: getImageBox(
                  serverApiUrl + serverPort + url,
                ),
              ))
          .toList(),
    );

    return getDialog(
      width: double.infinity,
      height: double.infinity,
      barrierColor: AppColors.mainBacground,
      child: Stack(
        children: [
          child,
          _backButton(pageController: pageController),
        ],
      ),
    );
  }

  static Future<dynamic> videoPage(String url, String snapshotUrl) {
    VideoPlayerController videoPlayerController =
        VideoPlayerController.network(serverApiUrl + serverPort + url);

    Widget child = Center(
      child: FutureBuilder(
        future: videoPlayerController.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            videoPlayerController.play();
            return AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(videoPlayerController),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Column(
              children: [
                const Spacer(),
                Column(
                  children: [
                    const CircularProgressIndicator(),
                    SizedBox(height: 10.h),
                    getSpan('加载视频...'),
                  ],
                ),
                const Spacer(),
              ],
            );
          }
        },
      ),
    );

    return getDialog(
      width: double.infinity,
      height: double.infinity,
      barrierColor: AppColors.mainBacground,
      child: Stack(
        children: [
          child,
          _backButton(videoPlayerController: videoPlayerController),
        ],
      ),
    );
  }
}
