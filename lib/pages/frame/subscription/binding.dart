import 'package:get/get.dart';
import 'package:pinker/pages/frame/subscription/controller.dart';

class SubscriptionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionController>(() => SubscriptionController());
  }
}
