import 'package:get/get.dart';

import 'package:pinker/pages/setting/set_phone/library.dart';

class SetPhoneBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetPhoneController>(() => SetPhoneController());
  }
}
