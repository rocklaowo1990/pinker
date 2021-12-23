import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/dynamic/media_view/library.dart';
import 'package:pinker/widgets/widgets.dart';

class ContentBoxController extends GetxController {
  final ContentBoxState state = ContentBoxState();

  // 初始化数据
  // 暂时还不知道为啥要在这里初始化
  void initState(ListElement item) {
    state.canSee = item.canSee;
    state.commentCount = item.commentCount;
    state.forwardCount = item.forwardCount;
    state.isLike = item.isLike;
    state.likeCount = item.likeCount;
    state.isForward = item.isForward;
    state.subStatus = item.subStatus ?? 0;
  }

  void handlePay() {
    state.canSee = 1;
  }

  void handleOpenVideo(ListElement item, String url) async {
    getMediaView(item, this, url: url);
  }

  void handleOpenImage(ListElement item, int index) async {
    getMediaView(item, this, index: index);
  }

  void handleOpenContent(ListElement item) async {
    getMediaView(item, this);
  }
}
