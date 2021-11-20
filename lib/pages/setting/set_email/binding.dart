import 'package:get/get.dart';
import 'package:pinker/pages/setting/set_email/library.dart';

class SetEmailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetEmailController>(() => SetEmailController());
  }
}
