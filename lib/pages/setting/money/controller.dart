import 'package:get/get.dart';

import 'package:pinker/pages/setting/money/library.dart';
import 'package:pinker/routes/app_pages.dart';

class MoneyController extends GetxController {
  final state = MoneyState();
  void handleSet(int id) async {
    Get.toNamed(
      AppRoutes.set + AppRoutes.money + AppRoutes.moneySet,
      arguments: id,
    );
  }
}
