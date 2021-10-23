import 'package:get/get.dart';
import 'package:pinker/pages/frame/register/library.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
