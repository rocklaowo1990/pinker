import 'dart:ui';

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

Future getMediaView(
  ListElement item,
  ContentBoxController contentBoxController, {
  int? index,
  String? url,
}) {
  Widget child = GetBuilder<MediaViewController>(
    init: MediaViewController(),
    builder: (controller) {
      // 初始化
      // 这种结构的只能在这里初始化
      // 在里面初始化需要在控制器里面加入index变量
      if (index != null) {
        controller.state.pageIndex = index;
      }

      // appBar 右侧的设置按钮
      Widget moreButton = getContentMore(
        item,
        background: Colors.black54,
        width: 20.w,
        height: 20.w,
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
              background: Colors.black54,
            ),
          ));

      // appBar
      AppBar appBar = getAppBar(
        Obx(() => controller.state.imagesList.isEmpty
            ? const SizedBox()
            : getSpan(
                '${controller.state.pageIndex + 1}/${controller.state.imagesList.length}')),
        leading: leading,
        actions: [
          moreButton,
          SizedBox(width: 4.w),
        ],
      );

      // 底部信息
      // 就是留言、喜欢、转发、分享那些
      Widget contentButton = Container(
        color: Colors.black54,
        child: getContentButton(item, contentBoxController),
      );

      // 头像信息和订阅组合
      // 还包括文本信息
      // 这里的组合统称为 contentBody
      Widget contentBody = Container(
        color: Colors.black54,
        padding: EdgeInsets.fromLTRB(9.w, 9.w, 9.w, 0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: getContentAvatar(item),
                ),
                Obx(() => contentBoxController.state.subStatus == 0
                    ? getButton(
                        child: getSpan('订阅'),
                        onPressed: () {},
                        padding: EdgeInsets.fromLTRB(10.w, 6, 10.w, 6),
                        side: BorderSide(
                            width: 0.5.w, color: AppColors.mainColor),
                        background: Colors.transparent,
                      )
                    : getButton(
                        child: getSpan('已订阅'),
                        padding: EdgeInsets.fromLTRB(10.w, 6, 10.w, 6)))
              ],
            ),
            if (item.works.content.isNotEmpty) SizedBox(height: 8.h),
            if (item.works.content.isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: getSpan(
                  item.works.content,
                  textAlign: TextAlign.start,
                ),
              ),
          ],
        ),
      );

      Widget filterBox(int type) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 8.0,
            sigmaY: 8.0,
          ),
          child: Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(9.w, 0, 9.w, 0),
              width: double.infinity,
              height: 70,
              child: Center(
                child: getContentPayBox(
                    item, type, contentBoxController, controller),
              ),
            ),
          ),
        );
      }

      // 顶层构造
      Widget body = Obx(
        () => AnimatedOpacity(
            opacity: controller.state.opacity,
            duration: const Duration(milliseconds: 300),
            child: Column(
              children: [
                appBar,
                const Spacer(),
                contentBody,
                contentButton,
                if (contentBoxController.state.canSee == 1 &&
                    item.works.video.url.isNotEmpty &&
                    controller.fijkPlayer != null)
                  getVideoController(
                    controller.fijkPlayer!,
                    controller.handleExitFlullScreen,
                    controller.handleEenterFlullScreen,
                  ),
              ],
            )),
      );
      // 底层
      // 用来装媒体的
      // 媒体部分比较重要，包含购买和是否可阅读等权限
      late Widget mediaBox;
      // 这种是直接传的视频地址，表示的是可以直接播放
      // 这种就不用考虑他是不是已经订阅了
      if (url != null) {
        controller.fijkPlayer = FijkPlayer();
        controller.fijkPlayer!
            .setDataSource(serverApiUrl + serverPort + url, autoPlay: true);

        mediaBox = Obx(() => FijkView(
              color: AppColors.mainBacground,
              player: controller.fijkPlayer!,
              panelBuilder: controller.state.isFullScreen
                  ? defaultFijkPanelBuilder
                  : (
                      FijkPlayer fijkPlayer,
                      FijkData fijkData,
                      BuildContext buildContext,
                      Size size,
                      Rect rect,
                    ) {
                      return const SizedBox();
                    },
            ));
        // 这里就是传入的图片都下标
        // 代表的意思就是媒体可能是图片（包含付费和未付费，也可能是没有付费的视频）
        // 没有付费的视频也是有三张图片的
      } else if (index != null) {
        controller.pageController = ExtendedPageController(initialPage: index);

        // 这里用来区分到底是图片媒体还是视频媒体
        // 图片不为空，那么就是图片媒体
        if (item.works.pics.isNotEmpty) {
          // 如果没有权限查看的话，最多展示四张图
          if (contentBoxController.state.canSee == 0) {
            for (int i = 0; i < 4; i++) {
              controller.state.imagesList.add(item.works.pics[i]);
            }
            // 如果有权限查看，那么就展示所有的图片
          } else {
            controller.state.imagesList.addAll(item.works.pics);
          }
          // 下面这里开始就是媒体的组成部分
          // 用的组件是可以缩放的图片工具
          mediaBox = Obx(() => contentBoxController.state.canSee == 0
              ? ExtendedImageGesturePageView.builder(
                  itemBuilder: (BuildContext context, int _index) {
                    if (_index >= 3) {
                      return Stack(
                        children: [
                          Center(
                            child: getImageBox(
                                controller.state.imagesList[_index],
                                mode: ExtendedImageMode.gesture),
                          ),
                          Container(color: AppColors.mainBacground50),
                          filterBox(1),
                        ],
                      );
                    } else {
                      return Center(
                        child: getImageBox(controller.state.imagesList[_index],
                            mode: ExtendedImageMode.gesture),
                      );
                    }
                  },
                  itemCount: controller.state.imagesList.length,
                  controller: controller.pageController,
                  onPageChanged: controller.handleOnPageChanged,
                )
              : ExtendedImageGesturePageView.builder(
                  itemBuilder: (BuildContext context, int _index) {
                    return Center(
                      child: getImageBox(controller.state.imagesList[_index],
                          mode: ExtendedImageMode.gesture),
                    );
                  },
                  itemCount: controller.state.imagesList.length,
                  controller: controller.pageController,
                  onPageChanged: controller.handleOnPageChanged,
                ));
          // 这里开始就是视频区域
          // 视频不可观看的时候，是有三张预览图
          // 第四章是视频的封面
          // 购买了以后就只有视频了
          // 这里就有点难处理
        } else {
          controller.state.imagesList.addAll(item.works.video.previewsUrls);
          controller.state.imagesList.add(item.works.video.snapshotUrl);

          mediaBox = Obx(() => contentBoxController.state.canSee == 0
              ? ExtendedImageGesturePageView.builder(
                  itemBuilder: (BuildContext context, int _index) {
                    if (_index < 3) {
                      return Center(
                        child: getImageBox(controller.state.imagesList[_index],
                            mode: ExtendedImageMode.gesture),
                      );
                    } else {
                      return Stack(
                        children: [
                          Center(
                            child: getImageBox(
                                controller.state.imagesList[_index],
                                mode: ExtendedImageMode.gesture),
                          ),
                          Container(color: AppColors.mainBacground50),
                          filterBox(2),
                        ],
                      );
                    }
                  },
                  itemCount: controller.state.imagesList.length,
                  controller: controller.pageController,
                  onPageChanged: controller.handleOnPageChanged,
                )
              : Obx(() => FijkView(
                    color: AppColors.mainBacground,
                    player: controller.fijkPlayer!,
                    panelBuilder: controller.state.isFullScreen
                        ? defaultFijkPanelBuilder
                        : (
                            FijkPlayer fijkPlayer,
                            FijkData fijkData,
                            BuildContext buildContext,
                            Size size,
                            Rect rect,
                          ) {
                            return const SizedBox();
                          },
                  )));
        }
        // 这里就是纯文本了
        // 没有任何媒体内容
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
