import 'package:get/instance_manager.dart';
import 'package:pinker/pages/application/chat/controller.dart';
import 'package:pinker/pages/application/community/controller.dart';

import 'package:pinker/pages/application/controller.dart';
import 'package:pinker/pages/application/home/controller.dart';
import 'package:pinker/pages/application/my/controller.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());

    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CommunityController>(() => CommunityController());
    Get.lazyPut<ChatController>(() => ChatController());
    Get.lazyPut<MyController>(() => MyController());
  }
}
