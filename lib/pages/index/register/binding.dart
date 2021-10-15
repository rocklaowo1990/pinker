import 'package:get/get.dart';
import 'package:pinker/pages/index/register/index.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
