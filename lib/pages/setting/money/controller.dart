import 'package:get/get.dart';

import 'package:pinker/pages/setting/money/library.dart';
import 'package:pinker/routes/app_pages.dart';

class MoneyController extends GetxController {
  final state = MoneyState();

  List<List<int>> payOnlyId = [
    [1, 2, 3],
    [0, 2, 3],
    [0, 1, 3],
    [0, 1, 2],
  ];

  void handleSet(int id) async {
    Get.toNamed(
      AppRoutes.set + AppRoutes.money + AppRoutes.moneySet,
      arguments: id,
    );
  }

  void handleResault() {
    state.resaultSingle.value = [0, 0, 0, 0];
    state.resault.value = [0, 0, 0, 0];
    List<int> resaultMa = [0, 0, 0, 0];

    List<int> maAll = [
      state.ma_0[0] + state.ma_1[0] + state.ma_2[0] + state.ma_3[0],
      state.ma_0[1] + state.ma_1[1] + state.ma_2[1] + state.ma_3[1],
      state.ma_0[2] + state.ma_1[2] + state.ma_2[2] + state.ma_3[2],
      state.ma_0[3] + state.ma_1[3] + state.ma_2[3] + state.ma_3[3],
    ];

    state.zhongJi.clear();
    state.zhongJi.addAll(maAll);

    var ma = [
      [state.ma_0[0], state.ma_0[1], state.ma_0[2], state.ma_0[3]],
      [state.ma_1[0], state.ma_1[1], state.ma_1[2], state.ma_1[3]],
      [state.ma_2[0], state.ma_2[1], state.ma_2[2], state.ma_2[3]],
      [state.ma_3[0], state.ma_3[1], state.ma_3[2], state.ma_3[3]],
    ];

    var only = [
      [state.playerOnly_0[0], state.playerOnly_0[1], state.playerOnly_0[2]],
      [state.playerOnly_1[0], state.playerOnly_1[1], state.playerOnly_1[2]],
      [state.playerOnly_2[0], state.playerOnly_2[1], state.playerOnly_2[2]],
      [state.playerOnly_3[0], state.playerOnly_3[1], state.playerOnly_3[2]],
    ];

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (i != j) {
          state.resaultSingle[i] += (state.ji[i] - state.ji[j]);
          if (ma[i][j] > 0) {
            print('o');

            for (int k = 0; k < 4; k++) {
              if (i != k && j != k) {
                state.resaultSingle[i] +=
                    (state.ji[j] - state.ji[k]) * ma[i][j];
              }
            }
          } else if (ma[i][j] == 0) {
            print('obje111111ct');

            for (int k = 0; k < 4; k++) {
              if (i != k) {
                state.resaultSingle[i] +=
                    (state.ji[i] - state.ji[k]) * ma[i][k];
              }
            }
            state.resaultSingle[i] += (state.ji[i] - state.ji[j]) * ma[i][j];
          }
          if (maAll[j] - ma[i][j] > 0) {
            print('object');
            for (int k = 0; k < maAll[j] - ma[i][j]; k++) {
              if (i != k && j != k) {
                state.resaultSingle[i] +=
                    (state.ji[i] - state.ji[j]) * ma[i][j];
              }
            }
          }
        }
      }

      for (int j = 0; j < 4; j++) {
        if (i == j) {
          resaultMa[i] += state.resaultSingle[i] * ma[i][j];
        }
      }

      for (int j = 0; j < 3; j++) {
        state.resaultSingle[i] += only[i][j];
      }
      state.resault[i] =
          state.resault[i] + state.resaultSingle[i] + resaultMa[i];
    }
  }
}
