import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/dynamic/media_view/library.dart';

import 'package:pinker/values/values.dart';

class MediaViewController extends GetxController {
  final MediaViewState state = MediaViewState();
  FijkPlayer? fijkPlayer;
  PageController pageController = PageController();

  int pageIndex = 0;
  void handleOnPageChanged(value) {
    state.pageIndex = value;
  }

  void handleOpcatiy() {
    state.opacityListen++;
  }

  Future<void> _getSubscribeInfo(
    Rx<ContentListEntities> contentList,
    int index,
  ) async {
    ResponseEntity responseEntity = await UserApi.oneSubscribeInfo(
      userId: contentList.value.list[index].author.userId,
    );

    if (responseEntity.code == 200) {
      state.subscribeInfo.value =
          SubscribeInfoEntities.fromJson(responseEntity.data);
      state.subscribeInfo.update((val) {});
    }
  }

  void handlePay(Rx<ContentListEntities> contentList, int index) async {
    /// 图片不为空，说明啥
    ///
    /// 说明购买的一定是视频
    ///
    /// 所以下放的购买是针对图片的增加
    if (contentList.value.list[index].works.pics.isNotEmpty) {
      if (contentList.value.list[index].works.pics.length > 4) {
        state.imagesList.addAll(
          contentList.value.list[index].works.pics.sublist(4),
        );
      }
    } else {
      state.imagesList.clear();
      fijkPlayer = FijkPlayer();
      fijkPlayer!.setDataSource(
          serverApiUrl +
              serverPort +
              contentList.value.list[index].works.video.url,
          autoPlay: true);
    }

    /// 每一次购买都需要刷新订阅权限，看看是不是订阅了
    /// 如果是订阅了，就要刷新一下订阅状态
    ResponseEntity responseEntity = await UserApi.oneSubscribeInfo(
      userId: contentList.value.list[index].author.userId,
    );
    if (responseEntity.code == 200) {
      state.subscribeInfo.value =
          SubscribeInfoEntities.fromJson(responseEntity.data);
      state.subscribeInfo.update((val) {});
    }
  }

  void handleLeading(Rx<ContentListEntities> contentList, int index) {
    contentList.update((val) {});
    Get.back();
  }

  void handleExitFlullScreen() {
    state.isFullScreen = false;
  }

  void handleEenterFlullScreen() {
    state.isFullScreen = true;
  }

  Future<void> init(
    Rx<ContentListEntities> contentList,
    int index, {
    int? imageIndex,
  }) async {
    await _getSubscribeInfo(contentList, index);
    state.isLoading = false;
    if (fijkPlayer == null && imageIndex != null) state.pageIndex = imageIndex;
  }

  @override
  void onReady() {
    super.onReady();
    if (fijkPlayer == null) pageController.jumpToPage(state.pageIndex);
    debounce(
      state.opacityListenRx,
      (int value) {
        state.opacity = state.opacity == 1.0 ? 0.0 : 1.0;
      },
      time: const Duration(milliseconds: 100),
    );
  }

  @override
  void onClose() {
    super.onClose();
    if (fijkPlayer != null) fijkPlayer!.release();
  }
}
