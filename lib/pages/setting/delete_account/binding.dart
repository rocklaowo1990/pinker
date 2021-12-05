import 'package:get/get.dart';
import 'package:pinker/pages/setting/delete_account/library.dart';

class DeleteAccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeleteAccountController>(() => DeleteAccountController());
  }
}
