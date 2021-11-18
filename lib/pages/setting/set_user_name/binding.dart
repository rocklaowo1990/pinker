import 'package:get/get.dart';
import 'package:pinker/pages/setting/set_user_name/library.dart';

class SetUserNameBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetUserNameController>(() => SetUserNameController());
  }
}
