import 'package:extended_image/extended_image.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/dynamic/media_view/library.dart';

class MediaViewController extends GetxController {
  final MediaViewState state = MediaViewState();
  FijkPlayer? fijkPlayer;
  ExtendedPageController? pageController;

  void handleOpcatiy() {
    state.opacityListen++;
  }

  void handleLeading() {
    print(state.opacity);
    Get.back();
  }

  @override
  void onReady() {
    super.onReady();

    debounce(
      state.opacityListenRx,
      (int value) {
        state.opacity = state.opacity == 1.0 ? 0.0 : 1.0;
      },
      time: const Duration(milliseconds: 200),
    );
  }

  @override
  void onClose() {
    if (fijkPlayer != null) {
      fijkPlayer!.release();
    }
    if (pageController != null) {
      pageController!.dispose();
    }
    super.onClose();
  }
}
