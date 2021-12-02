import 'package:get/get.dart';

class SetGroupInfoState {
  /// 按钮是否禁用
  final RxBool _isDissable = true.obs;
  set isDissable(value) => _isDissable.value = value;
  bool get isDissable => _isDissable.value;

  /// 头像
  final RxInt _image = 0.obs;
  set image(value) => _image.value = value;
  int get image => _image.value;
}
