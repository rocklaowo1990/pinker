import 'package:get/get.dart';
import 'package:pinker/pages/unknown/controller.dart';

class UnknownBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UnknownController>(() => UnknownController());
  }
}
