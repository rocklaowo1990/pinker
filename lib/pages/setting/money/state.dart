import 'package:get/get.dart';

class MoneyState {
  RxList<int> resault = [0, 0, 0, 0].obs;

  RxList<int> resaultOnly = [0, 0, 0, 0].obs;

  RxList<int> ji = [0, 0, 0, 0].obs;

  RxList<int> ma_0 = [0, 0, 0, 0].obs;
  RxList<int> ma_1 = [0, 0, 0, 0].obs;
  RxList<int> ma_2 = [0, 0, 0, 0].obs;
  RxList<int> ma_3 = [0, 0, 0, 0].obs;

  RxList<int> playerOnly_0 = [0, 0, 0].obs;
  RxList<int> playerOnly_1 = [0, 0, 0].obs;
  RxList<int> playerOnly_2 = [0, 0, 0].obs;
  RxList<int> playerOnly_3 = [0, 0, 0].obs;

  /// 是否手机注册，否则就是邮箱
  final RxBool _isReset = true.obs;
  set isReset(value) => _isReset.value = value;
  bool get isReset => _isReset.value;
}
