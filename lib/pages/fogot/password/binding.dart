import 'package:get/instance_manager.dart';
import 'package:pinker/pages/fogot/password/library.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}
