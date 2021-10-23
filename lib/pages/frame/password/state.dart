import 'package:get/get.dart';

class PasswordState {
  /// 按钮是否禁用
  final RxBool _isDissable = true.obs;
  set isDissable(value) => _isDissable.value = value;
  bool get isDissable => _isDissable.value;
}
