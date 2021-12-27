import 'package:get/get.dart';
import 'package:pinker/pages/setting/money/controller.dart';

import 'package:pinker/pages/setting/money/money_set/library.dart';

class MoneySetController extends GetxController {
  final state = MoneySetState();
  final MoneyController moneyController = Get.find();
  final int arguments = Get.arguments;

  void handleBack() {
    Get.back();
  }

  void handleOnChangedNoValue() {
    state.isHu = state.isHu == 0 ? 1 : 0;
  }

  void handleSetGroup() {}

  void handleOnChanged(value) {
    state.isHu = value ? 1 : 0;
  }
}
