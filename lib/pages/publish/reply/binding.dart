import 'package:get/instance_manager.dart';

import 'package:pinker/pages/publish/reply/library.dart';

class ReplyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReplyController>(() => ReplyController());
  }
}
