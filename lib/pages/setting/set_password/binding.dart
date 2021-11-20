import 'package:get/get.dart';

import 'package:pinker/pages/setting/set_password/library.dart';

class SetPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetPasswordController>(() => SetPasswordController());
  }
}
