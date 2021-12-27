import 'package:get/get.dart';

class MoneySetState {
  /// 是否胡牌
  final RxInt _isHu = 0.obs;
  set isHu(int value) => _isHu.value = value;
  int get isHu => _isHu.value;
}
