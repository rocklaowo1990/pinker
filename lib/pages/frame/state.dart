import 'package:get/get.dart';

class FrameState {
  /// 控制页面蒙版
  final RxBool _isShowMax = false.obs;
  set isShowMax(value) => _isShowMax.value = value;
  bool get isShowMax => _isShowMax.value;
}
