import 'package:get/get.dart';

class FrameState {
  /// 控制页面蒙版
  final RxInt _pageIndex = 0.obs;
  set pageIndex(value) => _pageIndex.value = value;
  int get pageIndex => _pageIndex.value;
}
