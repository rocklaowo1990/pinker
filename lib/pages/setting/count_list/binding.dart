import 'package:get/get.dart';
import 'package:pinker/pages/setting/count_list/library.dart';

class SetCountListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetCountListController>(() => SetCountListController());
  }
}
