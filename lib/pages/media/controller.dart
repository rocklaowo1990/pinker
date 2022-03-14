import 'package:extended_image/extended_image.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';

import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/media/library.dart';
import 'package:pinker/values/values.dart';

class MediaController extends GetxController {
  final state = MediaState();
  final arguments = Get.arguments;

  FijkPlayer? fijkPlayer;
  ExtendedPageController pageController = ExtendedPageController();

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
          serverMediaUrl + contentList.value.list[index].works.video.url,
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

  @override
  void onReady() async {
    super.onReady();
    if (fijkPlayer == null && arguments['imageIndex'] != null) {
      state.pageIndex = arguments['imageIndex'];
      pageController.jumpToPage(state.pageIndex);
    }
    state.isLoading = false;
    await _getSubscribeInfo(arguments['contentList'], arguments['index']);
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
