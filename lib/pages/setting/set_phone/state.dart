import 'package:get/get.dart';

class SetPhoneState {
  /// 按钮是否禁用
  final RxBool _isDissable = true.obs;
  set isDissable(bool value) => _isDissable.value = value;
  bool get isDissable => _isDissable.value;

  ///
  final RxString _code = '86'.obs;
  set code(String value) => _code.value = value;
  String get code => _code.value;
}
