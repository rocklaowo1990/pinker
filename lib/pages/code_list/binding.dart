import 'package:get/get.dart';
import 'package:pinker/pages/code_list/controller.dart';

class CodeListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CodeListController>(() => CodeListController());
  }
}
