import 'package:get/instance_manager.dart';
import 'package:pinker/pages/fogot/index/library.dart';

class ForgotIndexBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotIndexController>(() => ForgotIndexController());
  }
}
