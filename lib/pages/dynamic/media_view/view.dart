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

Future getMediaView(ListElement item, ContentBoxController contentBoxController,
    {int? index, String? url}) {
  Widget child = GetBuilder<MediaViewController>(
    init: MediaViewController(),
    builder: (controller) {
      // 顶层的头像
      Widget avatar = getImageBox(
        item.author.avatar,
        shape: BoxShape.circle,
        width: 18.w,
        height: 18.w,
      );

      // appBar 右侧的设置按钮
      Widget moreButton = Center(
        child: getButton(
          width: 20.w,
          height: 20.w,
          background: AppColors.mainBacground50,
          onPressed: () {},
          child: const Icon(
            Icons.more_horiz,
            color: AppColors.mainIcon,
          ),
        ),
      );

      // appBar 左侧的返回按钮
      Widget leading = Obx(() => Center(
            child: getButton(
              height: 20.w,
              width: 20.w,
              child: SvgPicture.asset('assets/svg/icon_back.svg'),
              onPressed: controller.state.opacity == 0.0
                  ? null
                  : controller.handleLeading,
              background: AppColors.mainBacground50,
            ),
          ));

      // appBar
      AppBar appBar = getAppBar(
        const SizedBox(),
        leading: leading,
        actions: [
          moreButton,
          SizedBox(width: 4.w),
        ],
      );

      // 顶层构造
      Widget body = Obx(
        () => AnimatedOpacity(
            opacity: controller.state.opacity,
            duration: const Duration(milliseconds: 300),
            child: Column(
              children: [
                appBar,
                avatar,
              ],
            )),
      );

      // 底层
      // 用来装媒体的
      // 媒体部分比较重要，包含购买和是否可阅读等权限
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
        controller.pageController = ExtendedPageController(initialPage: index);

        if (item.works.pics.isNotEmpty) {
          if (contentBoxController.state.canSee == 0) {
            for (int i = 0; i < 4; i++) {
              controller.state.imagesList.add(item.works.pics[i]);
            }
          } else {
            controller.state.imagesList.addAll(item.works.pics);
          }
          mediaBox = Obx(() => ExtendedImageGesturePageView.builder(
                itemBuilder: (BuildContext context, int _index) {
                  if (_index >= 3 && contentBoxController.state.canSee == 0) {
                    return getButton(
                        child: getSpan('text'),
                        onPressed: () {
                          contentBoxController.state.canSee = 1;

                          controller.state.imagesList.clear();
                          controller.state.imagesList.addAll(item.works.pics);
                        });
                  } else {
                    return Center(
                      child: getImageBox(controller.state.imagesList[_index],
                          mode: ExtendedImageMode.gesture),
                    );
                  }
                },
                itemCount: controller.state.imagesList.length,
                controller: controller.pageController,
              ));
        } else {
          controller.state.imagesList.addAll(item.works.video.previewsUrls);
          controller.state.imagesList.add(item.works.video.snapshotUrl);

          mediaBox = Obx(() => controller.state.imagesList.isNotEmpty
              ? ExtendedImageGesturePageView.builder(
                  itemBuilder: (BuildContext context, int _index) {
                    if (_index < 3) {
                      return Center(
                        child: getImageBox(controller.state.imagesList[_index],
                            mode: ExtendedImageMode.gesture),
                      );
                    } else {
                      return getButton(
                          child: getSpan('text'),
                          onPressed: () {
                            contentBoxController.state.canSee = 1;
                            controller.state.imagesList.clear();
                            controller.fijkPlayer = FijkPlayer();
                            controller.fijkPlayer!.setDataSource(
                                serverApiUrl +
                                    serverPort +
                                    item.works.video.url,
                                autoPlay: true);
                          });
                    }
                  },
                  itemCount: controller.state.imagesList.length,
                  controller: controller.pageController,
                )
              : FijkView(
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
                ));
        }
      } else {
        mediaBox = Container();
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
