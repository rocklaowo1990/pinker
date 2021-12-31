import 'package:get/get.dart';

import 'package:pinker/pages/setting/money/library.dart';
import 'package:pinker/pages/setting/money/state.dart';
import 'package:pinker/routes/app_pages.dart';

class MoneyController extends GetxController {
  final state = MoneyState();

  void handleSet(Rx<MoneySystems> player) async {
    Get.toNamed(
      AppRoutes.set + AppRoutes.money + AppRoutes.moneySet,
      arguments: player,
    );
  }

  void handleResault() {
    state.player_1.update((val) {
      val!.resault++;
    });
    state.player_2.update((val) {
      val!.resault--;
    });
  }

  void handleReset() {
    state.player_1.value = MoneySystems.fromJson({
      'playerId': 1,
      'resault': 0,
      'beBuy': 0,
      'ji': 0,
      'only_1': 0,
      'only_2': 0,
      'only_3': 0,
      'ma_1': 0,
      'ma_2': 0,
      'ma_3': 0,
      'ma_4': 0,
    });
    state.player_1.update((val) {});
    state.player_2.value = MoneySystems.fromJson({
      'playerId': 2,
      'resault': 0,
      'beBuy': 0,
      'ji': 0,
      'only_1': 0,
      'only_2': 0,
      'only_3': 0,
      'ma_1': 0,
      'ma_2': 0,
      'ma_3': 0,
      'ma_4': 0,
    });
    state.player_2.update((val) {});
    state.player_3.value = MoneySystems.fromJson({
      'playerId': 3,
      'resault': 0,
      'beBuy': 0,
      'ji': 0,
      'only_1': 0,
      'only_2': 0,
      'only_3': 0,
      'ma_1': 0,
      'ma_2': 0,
      'ma_3': 0,
      'ma_4': 0,
    });
    state.player_3.update((val) {});
    state.player_4.value = MoneySystems.fromJson({
      'playerId': 4,
      'resault': 0,
      'beBuy': 0,
      'ji': 0,
      'only_1': 0,
      'only_2': 0,
      'only_3': 0,
      'ma_1': 0,
      'ma_2': 0,
      'ma_3': 0,
      'ma_4': 0,
    });
    state.player_4.update((val) {});
  }
}
