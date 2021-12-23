import 'package:get/instance_manager.dart';
import 'package:pinker/pages/application/community/new/library.dart';

class ContentListNewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContentListNewController>(() => ContentListNewController());
  }
}
