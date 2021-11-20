import 'package:get/get.dart';

class ForgotState {
  /// 当前页面
  final _pageIndex = 0.obs;
  set pageIndex(int value) => _pageIndex.value = value;
  int get pageIndex => _pageIndex.value;

  /// 验证方式
  final RxInt _verifyType = 1.obs;
  set verifyType(int value) => _verifyType.value = value;
  int get verifyType => _verifyType.value;

  /// 发送验证码的时间
  final RxInt sendTimeRx = 0.obs;
  set sendTime(int value) => sendTimeRx.value = value;
  int get sendTime => sendTimeRx.value;
}
