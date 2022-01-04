import 'package:get/get.dart';
import 'package:pinker/pages/setting/money/controller.dart';

import 'package:pinker/pages/setting/money/money_set/library.dart';
import 'package:pinker/pages/setting/money/state.dart';

class MoneySetController extends GetxController {
  final state = MoneySetState();
  final MoneyController moneyController = Get.find();
  final Rx<MoneySystems> arguments = Get.arguments;

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

  void changeBebuy() {
    moneyController.state.player_1.value.beBuy =
        moneyController.state.player_1.value.ma_1 +
            moneyController.state.player_2.value.ma_1 +
            moneyController.state.player_3.value.ma_1 +
            moneyController.state.player_4.value.ma_1;

    moneyController.state.player_2.value.beBuy =
        moneyController.state.player_1.value.ma_2 +
            moneyController.state.player_2.value.ma_2 +
            moneyController.state.player_3.value.ma_2 +
            moneyController.state.player_4.value.ma_2;

    moneyController.state.player_3.value.beBuy =
        moneyController.state.player_1.value.ma_3 +
            moneyController.state.player_2.value.ma_3 +
            moneyController.state.player_3.value.ma_3 +
            moneyController.state.player_4.value.ma_3;

    moneyController.state.player_4.value.beBuy =
        moneyController.state.player_1.value.ma_4 +
            moneyController.state.player_2.value.ma_4 +
            moneyController.state.player_3.value.ma_4 +
            moneyController.state.player_4.value.ma_4;

    moneyController.state.player_1.update((val) {});
    moneyController.state.player_2.update((val) {});
    moneyController.state.player_3.update((val) {});
    moneyController.state.player_4.update((val) {});
  }
}
