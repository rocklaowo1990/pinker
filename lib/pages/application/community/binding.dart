import 'package:get/instance_manager.dart';
import 'package:pinker/pages/application/community/controller.dart';

class CommunityBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityController>(() => CommunityController());
  }
}
