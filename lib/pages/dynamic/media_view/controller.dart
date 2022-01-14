import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/dynamic/media_view/library.dart';

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

  void init(int imageIndex) {
    if (fijkPlayer == null) state.pageIndex = imageIndex;
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
}
