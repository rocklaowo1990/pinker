import 'package:get/get.dart';
import 'package:pinker/pages/fogot/controller.dart';

class ForgotBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotController>(() => ForgotController());
  }
}
