import 'package:get/instance_manager.dart';
import 'package:pinker/pages/application/library.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
  }
}
