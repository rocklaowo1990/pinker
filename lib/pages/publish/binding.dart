import 'package:get/instance_manager.dart';

import 'package:pinker/pages/publish/library.dart';

class PublishBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PublishController>(() => PublishController());
  }
}
