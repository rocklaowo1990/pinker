import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/widgets/widgets.dart';

class ContentBoxController extends GetxController {
  void handleOpenVideo(String url) async {
    MediaView.videoPage(url);
  }

  void handleOpenImage(ListElement item, int index) async {
    MediaView.imagePage(item, index);
  }
}
