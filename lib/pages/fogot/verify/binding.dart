import 'package:get/instance_manager.dart';
import 'package:pinker/pages/fogot/verify/library.dart';

class ForgotVerifyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotVerifyController>(() => ForgotVerifyController());
  }
}
