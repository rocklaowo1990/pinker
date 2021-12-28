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
    state.resaultOnly.value = [0, 0, 0, 0];
    state.resault.value = [0, 0, 0, 0];
    List<int> numberMa = [
      state.ma_0[0] + state.ma_1[0] + state.ma_2[0] + state.ma_3[0],
      state.ma_0[1] + state.ma_1[1] + state.ma_2[1] + state.ma_3[1],
      state.ma_0[2] + state.ma_1[2] + state.ma_2[2] + state.ma_3[2],
      state.ma_0[3] + state.ma_1[3] + state.ma_2[3] + state.ma_3[3],
    ];
    List<int> numberPay = [0, 0, 0, 0];
    List<int> ma = [0, 0, 0, 0];

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (i != j) {
          state.resaultOnly[i] =
              state.resaultOnly[i] + (state.ji[i] - state.ji[j]);
        }
      }
    }

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (i == 0) {
          numberPay[i] = numberPay[i] +
              (state.ji[i] - state.ji[j]) * (numberMa[j] - state.ma_0[j]);
        } else if (i != j && i == 1) {
          numberPay[i] = numberPay[i] +
              (state.ji[i] - state.ji[j]) * (numberMa[j] - state.ma_1[j]);
        } else if (i != j && i == 2) {
          numberPay[i] = numberPay[i] +
              (state.ji[i] - state.ji[j]) * (numberMa[j] - state.ma_2[j]);
        } else if (i != j && i == 3) {
          numberPay[i] = numberPay[i] +
              (state.ji[i] - state.ji[j]) * (numberMa[j] - state.ma_3[j]);
        }
      }
    }
    print(numberPay);

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (i == j) {
          if (i == 0) {
            numberMa[i] = numberMa[i] + state.ma_0[j] * state.resaultOnly[j];
          } else if (i == 1) {
            numberMa[i] = numberMa[i] + state.ma_1[j] * state.resaultOnly[j];
          } else if (i == 2) {
            numberMa[i] = numberMa[i] + state.ma_2[j] * state.resaultOnly[j];
          } else if (i == 3) {
            numberMa[i] = numberMa[i] + state.ma_3[j] * state.resaultOnly[j];
          }
        } else {
          if (i == 0) {
            numberMa[i] = numberMa[i] +
                state.ma_0[j] * state.resaultOnly[j] -
                state.ji[i] * state.ma_0[i];
          } else if (i == 1) {
            numberMa[i] = numberMa[i] +
                state.ma_1[j] * state.resaultOnly[j] -
                state.ji[i] * state.ma_1[i];
          } else if (i == 2) {
            numberMa[i] = numberMa[i] +
                state.ma_2[j] * state.resaultOnly[j] -
                state.ji[i] * state.ma_2[i];
          } else if (i == 3) {
            numberMa[i] = numberMa[i] +
                state.ma_3[j] * state.resaultOnly[j] -
                state.ji[i] * state.ma_3[i];
          }
        }
      }
    }
    for (int i = 0; i < 4; i++) {
      state.resault[i] = numberPay[i] + state.resaultOnly[i] + ma[i];
    }
  }
}
