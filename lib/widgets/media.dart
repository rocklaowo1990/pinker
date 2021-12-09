import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class MediaWidgets {
  static Widget _backButton({PageController? pageController}) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, top: 24.w),
      child: getButton(
        height: 24.w,
        width: 24.w,
        background: Colors.black54,
        child: SvgPicture.asset('assets/svg/icon_back.svg'),
        onPressed: () {
          Get.back();
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
          .map((e) => Center(
                child: ExtendedImage.network(
                  serverApiUrl + serverPort + e,
                  fit: BoxFit.cover,
                  cache: true,
                  mode: ExtendedImageMode.gesture,
                  initGestureConfigHandler: (state) {
                    return GestureConfig(
                      minScale: 1.0,
                      animationMinScale: 0.7,
                      maxScale: 3.0,
                      animationMaxScale: 3.5,
                      speed: 1.0,
                      inertialSpeed: 100.0,
                      initialScale: 1.0,
                      inPageView: false,
                      initialAlignment: InitialAlignment.center,
                    );
                  },
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
          _backButton(),
        ],
      ),
    );
  }
}
