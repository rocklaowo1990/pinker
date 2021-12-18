import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/dynamic/content_list/library.dart';
import 'package:pinker/pages/dynamic/media_view/library.dart';

class ContentBoxController extends GetxController {
  final ContentBoxState state = ContentBoxState();

  // 初始化数据
  // 暂时还不知道为啥要在这里初始化
  void initState(ListElement item) {
    state.canSee = item.canSee;
  }

  void handleOpenVideo(ListElement item, String url) async {
    getMediaView(item, url: url);
  }

  void handleOpenImage(ListElement item, int index) async {
    getMediaView(item, index: index);
  }

  void handleOpenContent(ListElement item) async {
    getMediaView(item);
  }
}
