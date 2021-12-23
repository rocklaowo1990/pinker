import 'package:get/instance_manager.dart';
import 'package:pinker/pages/application/community/hot/library.dart';

class ContentListHotBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContentListHotController>(() => ContentListHotController());
  }
}
