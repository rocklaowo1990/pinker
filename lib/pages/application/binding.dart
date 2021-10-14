import 'package:get/instance_manager.dart';
import 'package:pinker/pages/application/index.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
  }
}
