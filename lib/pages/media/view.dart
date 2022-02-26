import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/media/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class MediaView extends GetView<MediaController> {
  const MediaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Rx<ContentListEntities> contentList =
        controller.arguments['contentList'];
    final int index = controller.arguments['index'];
    final int? imageIndex = controller.arguments['imageIndex'];
    // appBar 右侧的设置按钮
    // Widget moreButton = getContentMore(
    //   contentList,
    //   index,
    //   width: 20,
    //   height: 20,
    // );

    // appBar 左侧的返回按钮
    Widget leading = Obx(() => Center(
          child: getButton(
            height: 60,
            width: 60,
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
      //   SizedBox(width: 4),
      // ],
    );

    // 底部信息
    // 就是留言、喜欢、转发、分享那些
    Widget contentButton = getContentButton(contentList, index);

    // 头像信息和订阅组合
    // 还包括文本信息
    // 这里的组合统称为 contentBody
    Widget contentBody = Column(
      children: [
        Row(
          children: [
            Expanded(
              child: getContentAvatar(contentList, index),
            ),
            Obx(() => controller.state.isLoading
                ? getButtonSheetOutline(
                    child: const Center(
                      child: SizedBox(
                        width: 13,
                        height: 13,
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
                                userId:
                                    contentList.value.list[index].author.userId,
                                userName: contentList
                                    .value.list[index].author.userName,
                                avatar:
                                    contentList.value.list[index].author.avatar,
                                reSault: () {
                                  controller.handlePay(contentList, index);
                                },
                              );
                            },
                          ))
          ],
        ),
        if (contentList.value.list[index].works.content.isNotEmpty)
          const SizedBox(height: 16),
        if (contentList.value.list[index].works.content.isNotEmpty)
          SizedBox(
            width: double.infinity,
            child: getSpan(
              contentList.value.list[index].works.content,
              textAlign: TextAlign.start,
            ),
          ),
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
              const Spacer(),
              Container(
                color: AppColors.mainBacground50,
                child: SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: contentBody,
                      ),
                      contentButton,
                      if (contentList.value.list[index].canSee == 1 &&
                          contentList
                              .value.list[index].works.video.url.isNotEmpty &&
                          controller.fijkPlayer != null)
                        getVideoController(
                          controller.fijkPlayer!,
                          controller.handleExitFlullScreen,
                          controller.handleEenterFlullScreen,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );

    Widget _filterBox({void Function()? reSault}) {
      return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 8.0,
          sigmaY: 8.0,
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
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
          () => ExtendedImageGesturePageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.handleOnPageChanged,
            itemCount: controller.state.imagesList.length,
            itemBuilder: ((context, _index) {
              if (contentList.value.list[index].canSee == 0 && _index == 3) {
                return Stack(
                  children: [
                    Center(
                      child: ExtendedImage.network(
                        serverApiUrl +
                            serverPort +
                            controller.state.imagesList[_index],
                        enableSlideOutPage: true,
                        mode: ExtendedImageMode.gesture,
                        initGestureConfigHandler: (state) {
                          return GestureConfig(
                            minScale: 0.9,
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
                    ),
                    _filterBox(
                      reSault: () {
                        controller.handlePay(contentList, index);
                      },
                    ),
                  ],
                );
              } else {
                return ExtendedImage.network(
                  serverApiUrl +
                      serverPort +
                      controller.state.imagesList[_index],
                  enableSlideOutPage: true,
                  mode: ExtendedImageMode.gesture,
                  initGestureConfigHandler: (state) {
                    return GestureConfig(
                      minScale: 0.9,
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
                );
              }
            }),
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
            ? ExtendedImageGesturePageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.handleOnPageChanged,
                itemCount: controller.state.imagesList.length,
                itemBuilder: ((context, _index) {
                  if (_index < 3) {
                    return ExtendedImage.network(
                      serverApiUrl +
                          serverPort +
                          controller.state.imagesList[_index],
                      // enableSlideOutPage: true,
                      mode: ExtendedImageMode.gesture,
                      initGestureConfigHandler: (state) {
                        return GestureConfig(
                          minScale: 0.9,
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
                    );
                  } else {
                    return Stack(
                      children: [
                        Center(
                          child: ExtendedImage.network(
                            serverApiUrl +
                                serverPort +
                                controller.state.imagesList[_index],
                            // enableSlideOutPage: true,
                            mode: ExtendedImageMode.gesture,
                            initGestureConfigHandler: (state) {
                              return GestureConfig(
                                minScale: 0.9,
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
                        ),
                        _filterBox(
                          reSault: () {
                            controller.handlePay(contentList, index);
                          },
                        ),
                      ],
                    );
                  }
                }),
              )
            // ? PhotoViewGallery.builder(
            //     builder: (BuildContext context, int _index) {
            //       Widget _getNetworkImageBox = getNetworkImageBox(
            //         controller.state.imagesList[_index],
            //       );
            //       return PhotoViewGalleryPageOptions.customChild(
            //           minScale: PhotoViewComputedScale.contained,
            //           maxScale: PhotoViewComputedScale.contained * 2,
            //           initialScale: PhotoViewComputedScale.contained,
            //           child: _index == 3
            //               ? Stack(
            //                   children: [
            //                     _getNetworkImageBox,
            //                     _filterBox(
            //                       reSault: () {
            //                         controller.handlePay(contentList, index);
            //                       },
            //                     ),
            //                   ],
            //                 )
            //               : _getNetworkImageBox);
            //     },
            //     pageController: controller.pageController,
            //     itemCount: controller.state.imagesList.length,
            //     onPageChanged: controller.handleOnPageChanged,
            //   )
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

    // return ExtendedImageSlidePage(
    //   slideType: SlideType.wholePage,
    //   child: Stack(
    //     children: [
    //       scaffold,
    //       body,
    //     ],
    //   ),
    // );
  }
}
