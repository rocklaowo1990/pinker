import 'package:get/get.dart';
import 'package:pinker/pages/frame/avatar/controller.dart';

class AvatarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AvatarController>(() => AvatarController());
  }
}
