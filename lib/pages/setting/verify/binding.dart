import 'package:get/get.dart';
import 'package:pinker/pages/setting/verify/library.dart';

class SetVerifyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetVerifyController>(() => SetVerifyController());
  }
}
