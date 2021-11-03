import 'package:get/instance_manager.dart';
import 'package:pinker/pages/application/my/controller.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyController>(() => MyController());
  }
}
