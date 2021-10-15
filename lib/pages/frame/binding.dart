import 'package:get/get.dart';
import 'package:pinker/pages/frame/controller.dart';

class FrameBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FrameController>(() => FrameController());
  }
}
