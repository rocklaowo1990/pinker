import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class MediaView {
  static Widget _backButton({
    ExtendedPageController? pageController,
    VideoPlayerController? videoPlayerController,
    ChewieController? chewieController,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, top: 24.w),
      child: getButton(
        height: 24.w,
        width: 24.w,
        background: Colors.black54,
        child: SvgPicture.asset('assets/svg/icon_back.svg'),
        onPressed: () {
          if (videoPlayerController != null) videoPlayerController.dispose();
          if (pageController != null) pageController.dispose();
          if (chewieController != null) chewieController.dispose();

          Get.back();
        },
      ),
    );
  }

  static Future<dynamic> imagePage(ListElement item, int index) {
    late List images;
    if (item.works.pics.isNotEmpty) {
      images = item.works.pics;
    } else {
      images = item.works.video.previewsUrls;
    }
    final ExtendedPageController pageController =
        ExtendedPageController(initialPage: index);

    Widget child = ExtendedImageGesturePageView.builder(
      itemBuilder: (BuildContext context, int _index) {
        return Center(
          child: getImageBox(
            serverApiUrl + serverPort + images[_index],
            mode: ExtendedImageMode.gesture,
          ),
        );
      },
      itemCount: images.length,
      controller: pageController,
    );

    return getDialog(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.mainBacground,
      child: Stack(
        children: [
          child,
          _backButton(pageController: pageController),
        ],
      ),
    );
  }

  static Future<dynamic> videoPage(String url, String snapshotUrl) {
    final VideoPlayerController videoPlayerController =
        VideoPlayerController.network(serverApiUrl + serverPort + url);

    ChewieController? chewieController;

    Widget child = Center(
      child: FutureBuilder(
        future: videoPlayerController.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            chewieController = ChewieController(
              videoPlayerController: videoPlayerController,
              autoPlay: true,
              looping: true,
            );

            return Chewie(
              controller: chewieController!,
            );
          } else {
            return Stack(
              children: [
                Center(
                  child: getImageBox(serverApiUrl + serverPort + snapshotUrl),
                ),
                const Center(child: CircularProgressIndicator()),
              ],
            );
          }
        },
      ),
    );

    return getDialog(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.mainBacground,
      child: Stack(
        children: [
          child,
          _backButton(
              videoPlayerController: videoPlayerController,
              chewieController: chewieController),
        ],
      ),
    );
  }
}
