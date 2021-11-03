import 'package:get/instance_manager.dart';
import 'package:pinker/pages/application/chat/controller.dart';

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
