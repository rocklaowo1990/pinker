import 'package:get/get.dart';

class SetGroupInfoState {
  /// 按钮是否禁用
  final RxBool _isDissable = true.obs;
  set isDissable(value) => _isDissable.value = value;
  bool get isDissable => _isDissable.value;

  /// 头像
  final RxInt imageRx = 0.obs;
  set image(value) => imageRx.value = value;
  int get image => imageRx.value;
}
