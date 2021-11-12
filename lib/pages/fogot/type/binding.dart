import 'package:get/instance_manager.dart';
import 'package:pinker/pages/fogot/type/library.dart';

class ForgotTypeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotTypeController>(() => ForgotTypeController());
  }
}
