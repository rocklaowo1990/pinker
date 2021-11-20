import 'package:get/get.dart';

class SetEmailState {
  /// 按钮是否禁用
  final RxBool _isDissable = true.obs;
  set isDissable(bool value) => _isDissable.value = value;
  bool get isDissable => _isDissable.value;

  /// code
  final RxString _code = '86'.obs;
  set code(String value) => _code.value = value;
  String get code => _code.value;

  /// 接收验证码的手机号码或者邮箱地址
  final RxString _account = ''.obs;
  set account(String value) => _account.value = value;
  String get account => _account.value;
}
