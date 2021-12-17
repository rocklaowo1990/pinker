import 'package:extended_image/extended_image.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/dynamic/dynamic.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

Future getMediaView(ListElement item, {int? index, String? url}) {
  Widget child = GetBuilder<MediaViewController>(
    init: MediaViewController(),
    builder: (controller) {
      Widget avatar = getImageBox(
        item.author.avatar,
        shape: BoxShape.circle,
        width: 18.w,
        height: 18.w,
      );

      // appBar 右侧的设置按钮
      Widget moreButton = getButton(
        width: 32.w,
        height: 32.w,
        background: Colors.transparent,
        onPressed: () {},
        child: const Icon(
          Icons.more_horiz,
          color: AppColors.mainIcon,
        ),
      );

      // appBar 左侧的返回按钮
      Widget leading = Obx(() => getButton(
            child: SvgPicture.asset('assets/svg/icon_back.svg'),
            onPressed: controller.state.opacity == 0.0
                ? null
                : controller.handleLeading,
            background: Colors.transparent,
          ));

      // appBar
      AppBar appBar = getAppBar(
        const SizedBox(),
        leading: leading,
        actions: [
          moreButton,
        ],
      );

      // 用来装媒体的
      late Widget mediaBox;

      if (url != null) {
        controller.fijkPlayer = FijkPlayer();
        controller.fijkPlayer!
            .setDataSource(serverApiUrl + serverPort + url, autoPlay: true);

        mediaBox = FijkView(
          color: AppColors.mainBacground,
          player: controller.fijkPlayer!,
          panelBuilder: (
            FijkPlayer fijkPlayer,
            FijkData fijkData,
            BuildContext buildContext,
            Size size,
            Rect rect,
          ) {
            return const SizedBox();
          },
        );
      } else if (index != null) {
        late List images;
        if (item.works.pics.isNotEmpty) {
          images = item.works.pics;
        } else {
          images = item.works.video.previewsUrls;
        }
        controller.pageController = ExtendedPageController(initialPage: index);

        mediaBox = ExtendedImageGesturePageView.builder(
          itemBuilder: (BuildContext context, int _index) {
            return Center(
              child:
                  getImageBox(images[_index], mode: ExtendedImageMode.gesture),
            );
          },
          itemCount: images.length,
          controller: controller.pageController,
        );
      }

      // 媒体的页面布局
      Widget scaffold = Scaffold(
        body: getButton(
          child: mediaBox,
          onPressed: controller.handleOpcatiy,
          borderRadius: BorderRadius.zero,
          background: Colors.transparent,
          overlayColor: Colors.transparent,
        ),
        backgroundColor: AppColors.mainBacground,
      );

      // 顶层构造
      Widget body = Obx(
        () => AnimatedOpacity(
            opacity: controller.state.opacity,
            duration: const Duration(milliseconds: 300),
            child: Column(
              children: [
                appBar,
              ],
            )),
      );

      // 整体构造
      return Stack(
        children: [
          scaffold,
          body,
        ],
      );
    },
  );
  return getDialog(
    child: child,
  );
}
