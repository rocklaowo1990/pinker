import 'package:get/get.dart';

class FrameState {
  /// 控制页面蒙版
  final RxInt _pageIndex = 0.obs;
  set pageIndex(int value) => _pageIndex.value = value;
  int get pageIndex => _pageIndex.value;

  /// 发送验证码的时间
  final RxInt sendTimeRx = 0.obs;
  set sendTime(int value) => sendTimeRx.value = value;
  int get sendTime => sendTimeRx.value;

  /// 页面路由状态，控制页面蒙版
  final RxString _pageRoute = ''.obs;
  set pageRoute(String value) => _pageRoute.value = value;
  String get pageRoute => _pageRoute.value;
}
