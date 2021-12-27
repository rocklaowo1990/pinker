import 'package:get/get.dart';
import 'package:pinker/pages/setting/money/library.dart';

class MoneyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoneyController>(() => MoneyController());
  }
}
