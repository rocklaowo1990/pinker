import 'package:get/get.dart';
import 'package:pinker/pages/setting/set_user_logo/library.dart';

class SetUserLogoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetUserLogoController>(() => SetUserLogoController());
  }
}
