import 'package:get/get.dart';
import 'package:pinker/pages/application/library.dart';
import 'package:pinker/pages/frame/controller.dart';

class FrameBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FrameController>(() => FrameController());
    Get.lazyPut<ApplicationController>(() => ApplicationController());
  }
}
