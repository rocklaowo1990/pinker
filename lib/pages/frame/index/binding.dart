import 'package:get/get.dart';
import 'package:pinker/pages/frame/index/index.dart';

class IndexBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IndexController>(() => IndexController());
  }
}
