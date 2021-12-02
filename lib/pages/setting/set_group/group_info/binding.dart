import 'package:get/get.dart';
import 'package:pinker/pages/setting/set_group/group_info/library.dart';

class SetGroupInfoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetGroupInfoController>(() => SetGroupInfoController());
  }
}
