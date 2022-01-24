import 'dart:ui';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import 'package:photo_view/photo_view_gallery.dart';

import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/dynamic/dynamic.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

Future<Widget?> getMediaView(
  Rx<ContentListEntities> contentList,
  int index, {
  String? storageKey,
  int? imageIndex,
}) {
  Widget child = GetBuilder<MediaViewController>(
    init: MediaViewController(),
    builder: (controller) {
      // 初始化
      // 这种结构的只能在这里初始化
      // 在里面初始化需要在控制器里面加入index变量

      controller.init(contentList, index, imageIndex: imageIndex);

      // appBar 右侧的设置按钮
      // Widget moreButton = getContentMore(
      //   contentList,
      //   index,
      //   width: 20.w,
      //   height: 20.w,
      // );

      // appBar 左侧的返回按钮
      Widget leading = Obx(() => Center(
            child: getButton(
              height: 20.w,
              width: 20.w,
              background: Colors.transparent,
              child: SvgPicture.asset('assets/svg/icon_back.svg'),
              onPressed: controller.state.opacity == 0.0
                  ? null
                  : () {
                      controller.handleLeading(contentList, index);
                    },
            ),
          ));

      // appBar
      AppBar appBar = getAppBar(
        Obx(() => controller.state.imagesList.isEmpty
            ? const SizedBox()
            : getSpan(
                '${controller.state.pageIndex + 1}/${controller.state.imagesList.length}')),
        leading: leading,
        backgroundColor: Colors.black54,
        // actions: [
        //   moreButton,
        //   SizedBox(width: 4.w),
        // ],
      );

      // 底部信息
      // 就是留言、喜欢、转发、分享那些
      Widget contentButton = Container(
        color: Colors.black54,
        child: getContentButton(contentList, index),
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
                  child: getContentAvatar(contentList, index),
                ),
                Obx(() => controller.state.isLoading
                    ? getButton(
                        width: 70,
                        borderSide: BorderSide(
                          width: 0.5.w,
                          color: AppColors.mainColor,
                        ),
                        background: Colors.transparent,
                        child: const Center(
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              backgroundColor: AppColors.mainIcon,
                              color: AppColors.mainColor,
                              strokeWidth: 1,
                            ),
                          ),
                        ),
                      )
                    : controller.state.subscribeInfo.value.subGroupList != null
                        ? getButtonSheet(
                            child: getSpan('已订阅'),
                          )
                        : controller.state.subscribeInfo.value.groups.isEmpty
                            ? const SizedBox()
                            : getButtonSheetOutline(
                                child: getSpan('订阅'),
                                onPressed: () {
                                  getSubscribeBox(
                                    userId: contentList
                                        .value.list[index].author.userId,
                                    userName: contentList
                                        .value.list[index].author.userName,
                                    avatar: contentList
                                        .value.list[index].author.avatar,
                                    reSault: () {
                                      controller.handlePay(contentList, index);
                                    },
                                  );
                                },
                              ))
              ],
            ),
            if (contentList.value.list[index].works.content.isNotEmpty)
              SizedBox(height: 8.h),
            if (contentList.value.list[index].works.content.isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: getSpan(
                  contentList.value.list[index].works.content,
                  textAlign: TextAlign.start,
                ),
              ),
          ],
        ),
      );

      Widget _filterBox({void Function()? reSault}) {
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
                  contentList,
                  index,
                  reSault: reSault,
                ),
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
                if (contentList.value.list[index].canSee == 1 &&
                    contentList.value.list[index].works.video.url.isNotEmpty &&
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
      if (imageIndex == null) {
        controller.fijkPlayer = FijkPlayer();
        controller.fijkPlayer!.setDataSource(
            serverApiUrl +
                serverPort +
                contentList.value.list[index].works.video.url,
            autoPlay: true);

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
        // 这里就是传入的图片下标
        // 代表的意思就是媒体可能是图片（包含付费和未付费，也可能是没有付费的视频）
        // 没有付费的视频也是有三张图片的
      } else {
        // 这里用来区分到底是图片媒体还是视频媒体
        // 图片不为空，那么就是图片媒体
        if (contentList.value.list[index].works.pics.isNotEmpty) {
          // 如果没有权限查看的话，最多展示四张图
          if (contentList.value.list[index].canSee == 0) {
            controller.state.imagesList
                .addAll(contentList.value.list[index].works.pics.sublist(0, 4));
            // 如果有权限查看，那么就展示所有的图片
          } else {
            controller.state.imagesList
                .addAll(contentList.value.list[index].works.pics);
          }
          // 下面这里开始就是媒体的组成部分
          // 用的组件是可以缩放的图片工具
          mediaBox = Obx(
            () => PhotoViewGallery.builder(
              builder: (BuildContext context, int _index) {
                Widget _getNetworkImageBox = getNetworkImageBox(
                  controller.state.imagesList[_index],
                );

                return PhotoViewGalleryPageOptions.customChild(
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  initialScale: PhotoViewComputedScale.contained,
                  child: Obx(() =>
                      contentList.value.list[index].canSee == 0 && _index == 3
                          ? Stack(
                              children: [
                                _getNetworkImageBox,
                                _filterBox(
                                  reSault: () {
                                    controller.handlePay(contentList, index);
                                  },
                                ),
                              ],
                            )
                          : _getNetworkImageBox),
                );
              },
              pageController: controller.pageController,
              itemCount: controller.state.imagesList.length,
              onPageChanged: controller.handleOnPageChanged,
            ),
          );
          // 这里开始就是视频区域
          // 视频不可观看的时候，是有三张预览图
          // 第四章是视频的封面
          // 购买了以后就只有视频了
          // 这里就有点难处理
        } else {
          controller.state.imagesList
              .addAll(contentList.value.list[index].works.video.previewsUrls);
          controller.state.imagesList
              .add(contentList.value.list[index].works.video.snapshotUrl);

          mediaBox = Obx(() => contentList.value.list[index].canSee == 0
              ? PhotoViewGallery.builder(
                  builder: (BuildContext context, int _index) {
                    Widget _getNetworkImageBox = getNetworkImageBox(
                      controller.state.imagesList[_index],
                    );
                    return PhotoViewGalleryPageOptions.customChild(
                        minScale: PhotoViewComputedScale.contained,
                        maxScale: PhotoViewComputedScale.covered * 2,
                        initialScale: PhotoViewComputedScale.contained,
                        child: _index == 3
                            ? Stack(
                                children: [
                                  _getNetworkImageBox,
                                  _filterBox(
                                    reSault: () {
                                      controller.handlePay(contentList, index);
                                    },
                                  ),
                                ],
                              )
                            : _getNetworkImageBox);
                  },
                  pageController: controller.pageController,
                  itemCount: controller.state.imagesList.length,
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
