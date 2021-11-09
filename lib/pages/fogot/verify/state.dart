import 'package:get/get.dart';

class ForgotVerifyState {
  /// 验证方式
  final RxInt _verifyType = 1.obs;
  set verifyType(int value) => _verifyType.value = value;
  int get verifyType => _verifyType.value;
}
