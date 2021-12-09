import 'package:get/get.dart';

class SetVerifyState {
  /// 需要验证的手机号或者邮箱
  final RxString _account = ''.obs;
  set account(String value) => _account.value = value;
  String get account => _account.value;
}
