import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/widgets/widgets.dart';

class ContentBoxController extends GetxController {
  void handleOpenVideo(String url, String snapshotUrl) async {
    MediaWidgets.videoPage(url, snapshotUrl);
  }

  void handleOpenImage(ListElement item, int index) async {
    MediaWidgets.imagePage(item, index);
  }
}
