import 'package:get/instance_manager.dart';

import 'package:pinker/pages/application/home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
