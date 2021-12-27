import 'package:get/get.dart';

import 'package:pinker/pages/setting/money/money_set/library.dart';

class MoneySetBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoneySetController>(() => MoneySetController());
  }
}
