import 'package:get/get.dart';

import 'package:pinker/pages/setting/money/library.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';

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

  void handleResault() {}

  void handleReset() {}
}
