import 'package:get/get.dart';

class FrameState {
  /// 控制页面蒙版
  final RxInt _pageIndex = 0.obs;
  set pageIndex(int value) => _pageIndex.value = value;
  int get pageIndex => _pageIndex.value;

  /// 控制页面蒙版
  final RxInt sendTimeRx = 0.obs;
  set sendTime(int value) => sendTimeRx.value = value;
  int get sendTime => sendTimeRx.value;
}
