import 'package:get/instance_manager.dart';

import 'package:pinker/pages/application/controller.dart';
import 'package:pinker/pages/application/my/library.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyController>(() => MyController());
    Get.lazyPut<ApplicationController>(() => ApplicationController());
  }
}
