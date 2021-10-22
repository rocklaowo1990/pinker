import 'package:get/get.dart';
import 'package:pinker/pages/frame/verify/controller.dart';

class VerifyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyController>(() => VerifyController());
  }
}
