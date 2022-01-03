import 'package:get/get.dart';

import 'package:pinker/pages/setting/money/library.dart';
import 'package:pinker/pages/setting/money/state.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';

class MoneyController extends GetxController {
  final state = MoneyState();

  void handleSet(Rx<MoneySystems> player) async {
    Get.toNamed(
      AppRoutes.set + AppRoutes.money + AppRoutes.moneySet,
      arguments: player,
    );
  }

  void handleResault() async {
    getDialog();

    state.player_1.value.beBuy = state.player_1.value.ma_1 +
        state.player_2.value.ma_1 +
        state.player_3.value.ma_1 +
        state.player_4.value.ma_1;

    state.player_2.value.beBuy = state.player_1.value.ma_2 +
        state.player_2.value.ma_2 +
        state.player_3.value.ma_2 +
        state.player_4.value.ma_2;

    state.player_3.value.beBuy = state.player_1.value.ma_3 +
        state.player_2.value.ma_3 +
        state.player_3.value.ma_3 +
        state.player_4.value.ma_3;

    state.player_4.value.beBuy = state.player_1.value.ma_4 +
        state.player_2.value.ma_4 +
        state.player_3.value.ma_4 +
        state.player_4.value.ma_4;

    state.player_1.value.only_1 = state.player_1.value.only_1 >= 0
        ? state.player_1.value.only_1 *
            (state.player_1.value.beBuy - state.player_2.value.ma_1 + 1)
        : state.player_1.value.only_1 *
            (state.player_2.value.beBuy - state.player_1.value.ma_2 + 1);
    state.player_2.value.only_1 = -state.player_1.value.only_1;

    state.player_1.value.only_2 =
        (state.player_3.value.beBuy - state.player_1.value.ma_3) *
            (state.player_1.value.ma_1 + 1);
    state.player_3.value.only_1 = -state.player_1.value.only_2;

    state.player_1.value.only_3 =
        (state.player_3.value.beBuy - state.player_1.value.ma_3) *
            (state.player_1.value.ma_1 + 1);
    state.player_4.value.only_1 = -state.player_1.value.only_3;

    state.player_2.value.only_2 =
        (state.player_3.value.beBuy - state.player_2.value.ma_3) *
            (state.player_1.value.ma_2 + 1);
    state.player_3.value.only_2 = -state.player_2.value.only_2;

    state.player_2.value.only_3 =
        (state.player_4.value.beBuy - state.player_2.value.ma_4) *
            (state.player_1.value.ma_2 + 1);
    state.player_4.value.only_2 = -state.player_2.value.only_3;

    state.player_3.value.only_3 =
        (state.player_4.value.beBuy - state.player_3.value.ma_4) *
            (state.player_3.value.ma_3 + 1);
    state.player_4.value.only_3 = -state.player_3.value.only_3;

    state.player_1.value.resault =
        (state.player_1.value.ji - state.player_2.value.ji) *
                (state.player_2.value.beBuy - state.player_1.value.ma_2 + 1) *
                (state.player_1.value.ma_1 + 1) +
            (state.player_1.value.ji - state.player_3.value.ji) *
                (state.player_3.value.beBuy - state.player_1.value.ma_3 + 1) *
                (state.player_1.value.ma_1 + 1) +
            (state.player_1.value.ji - state.player_4.value.ji) *
                (state.player_4.value.beBuy - state.player_1.value.ma_4 + 1) *
                (state.player_1.value.ma_1 + 1) +
            state.player_1.value.only_1 +
            state.player_1.value.only_2 +
            state.player_1.value.only_3;

    state.player_2.value.resault =
        (state.player_2.value.ji - state.player_1.value.ji) +
            (state.player_2.value.ji - state.player_3.value.ji) +
            (state.player_2.value.ji - state.player_4.value.ji) +
            (state.player_2.value.ji - state.player_1.value.ji) *
                (state.player_1.value.beBuy - state.player_2.value.ma_1) *
                (state.player_2.value.ma_2) +
            (state.player_2.value.ji - state.player_3.value.ji) *
                (state.player_3.value.beBuy - state.player_2.value.ma_3) *
                (state.player_2.value.ma_2) +
            (state.player_2.value.ji - state.player_4.value.ji) *
                (state.player_4.value.beBuy - state.player_2.value.ma_4) *
                (state.player_2.value.ma_2) +
            state.player_2.value.only_1 +
            state.player_2.value.only_2 +
            state.player_2.value.only_3;

    state.player_3.value.resault =
        (state.player_3.value.ji - state.player_1.value.ji) *
                (state.player_1.value.beBuy - state.player_3.value.ma_1 + 1) *
                (state.player_3.value.ma_3 + 1) +
            (state.player_3.value.ji - state.player_2.value.ji) *
                (state.player_2.value.beBuy - state.player_3.value.ma_2 + 1) *
                (state.player_3.value.ma_3 + 1) +
            (state.player_3.value.ji - state.player_4.value.ji) *
                (state.player_4.value.beBuy - state.player_3.value.ma_4 + 1) *
                (state.player_3.value.ma_3 + 1) +
            state.player_3.value.only_1 +
            state.player_3.value.only_2 +
            state.player_3.value.only_3;

    state.player_4.value.resault =
        (state.player_4.value.ji - state.player_1.value.ji) *
                (state.player_1.value.beBuy - state.player_4.value.ma_1 + 1) *
                (state.player_4.value.ma_4 + 1) +
            (state.player_4.value.ji - state.player_2.value.ji) *
                (state.player_2.value.beBuy - state.player_4.value.ma_2 + 1) *
                (state.player_4.value.ma_4 + 1) +
            (state.player_4.value.ji - state.player_3.value.ji) *
                (state.player_3.value.beBuy - state.player_4.value.ma_3 + 1) *
                (state.player_4.value.ma_4 + 1) +
            state.player_4.value.only_1 +
            state.player_4.value.only_2 +
            state.player_4.value.only_3;
    await futureMill(500);
    Get.back();
    state.player_1.update((val) {});
    state.player_2.update((val) {});
    state.player_3.update((val) {});
    state.player_4.update((val) {});
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
      'onlyId_1': 2,
      'onlyId_2': 3,
      'onlyId_3': 4,
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
      'onlyId_1': 1,
      'onlyId_2': 3,
      'onlyId_3': 4,
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
      'onlyId_1': 1,
      'onlyId_2': 2,
      'onlyId_3': 4,
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
      'onlyId_1': 1,
      'onlyId_2': 2,
      'onlyId_3': 3,
      'ma_1': 0,
      'ma_2': 0,
      'ma_3': 0,
      'ma_4': 0,
    });
    state.player_4.update((val) {});
  }
}
