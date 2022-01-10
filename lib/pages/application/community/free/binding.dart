import 'package:get/instance_manager.dart';
import 'package:pinker/pages/application/community/free/library.dart';

class ContentListFreeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContentListFreeController>(() => ContentListFreeController());
  }
}
