import 'package:get/instance_manager.dart';

import 'package:pinker/pages/subscribe_list/library.dart';

class SubscribeListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscribeListController>(() => SubscribeListController());
  }
}
