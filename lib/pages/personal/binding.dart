import 'package:get/instance_manager.dart';

import 'package:pinker/pages/personal/library.dart';

class PersonalBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalController>(() => PersonalController());
  }
}
