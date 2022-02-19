import 'package:get/get.dart';

import 'package:pinker/pages/media/library.dart';

class MediaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MediaController>(() => MediaController());
  }
}
