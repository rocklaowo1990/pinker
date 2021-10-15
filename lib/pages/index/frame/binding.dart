import 'package:get/get.dart';
import 'package:pinker/pages/index/frame/index.dart';

class FrameBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FrameController>(() => FrameController());
  }
}
