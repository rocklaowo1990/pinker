import 'package:get/get.dart';

import 'package:pinker/pages/setting/set_group/library.dart';

class SetGroupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetGroupController>(() => SetGroupController());
  }
}
