import 'package:get/get.dart';

class SetUserLogoState {
  /// 按钮是否禁用
  final RxBool _isDissable = true.obs;
  set isDissable(bool value) => _isDissable.value = value;
  bool get isDissable => _isDissable.value;

  /// 开关控制器
  final RxInt _enable = 0.obs;
  set enable(int value) => _enable.value = value;
  int get enable => _enable.value;

  /// 是否在请求数据
  final RxBool _isLoading = true.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;
}
