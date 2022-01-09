import 'package:get/get.dart';

class RegisterState {
  /// 按钮是否禁用
  final RxBool _isAccountPass = true.obs;
  set isAccountPass(value) => _isAccountPass.value = value;
  bool get isAccountPass => _isAccountPass.value;

  /// 是否手机注册，否则就是邮箱
  final RxBool _isPhone = true.obs;
  set isPhone(value) => _isPhone.value = value;
  bool get isPhone => _isPhone.value;

  /// 是否选中
  final RxBool _isChooise = false.obs;
  set isChooise(value) => _isChooise.value = value;
  bool get isChooise => _isChooise.value;

  /// 时间节流
  final Rx<DateTime> timeChangeRx = DateTime(1990, 1, 1).obs;
  set timeChange(value) => timeChangeRx.value = value;
  DateTime get timeChange => timeChangeRx.value;

  /// 时间显示
  final Rx<DateTime> _showTime = DateTime(1990, 1, 1).obs;
  set showTime(DateTime value) => _showTime.value = value;
  DateTime get showTime => _showTime.value;

  /// 区号
  final RxString codeRx = '86'.obs;
  set code(String value) => codeRx.value = value;
  String get code => codeRx.value;
}
