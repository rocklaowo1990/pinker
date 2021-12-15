import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/widgets/widgets.dart';

class ContentBoxController extends GetxController {
  void handleOpenVideo(String url, String snapshotUrl) async {
    MediaView.videoPage(url, snapshotUrl);
  }

  void handleOpenImage(ListElement item, int index) async {
    MediaView.imagePage(item, index);
  }
}
