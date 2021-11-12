import 'package:get/instance_manager.dart';
import 'package:pinker/pages/fogot/info/library.dart';

class ForgotInfoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotInfoController>(() => ForgotInfoController());
  }
}
