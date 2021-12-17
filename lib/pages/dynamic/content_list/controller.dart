import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/dynamic/media_view/library.dart';

class ContentBoxController extends GetxController {
  void handleOpenVideo(ListElement item, String url) async {
    getMediaView(item, url: url);
  }

  void handleOpenImage(ListElement item, int index) async {
    getMediaView(item, index: index);
  }
}
