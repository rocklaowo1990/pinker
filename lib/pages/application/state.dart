import 'package:get/get.dart';

class ApplicationState {
  /// 防抖监听
  final RxInt rxInt = 0.obs;
  set rxIntValue(int value) => rxInt.value = value;
  int get rxIntValue => rxInt.value;

  /// 页面控制器
  final RxInt _pageIndex = 0.obs;
  set pageIndex(int value) => _pageIndex.value = value;
  int get pageIndex => _pageIndex.value;

  /// 用户信息
  final RxMap<String, dynamic> _userInfo = <String, dynamic>{}.obs;
  set userInfo(Map<String, dynamic> value) => _userInfo.value = value;
  Map<String, dynamic> get userInfo => _userInfo;
}
