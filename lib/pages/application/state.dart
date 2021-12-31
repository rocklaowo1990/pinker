import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';

class ApplicationState {
  /// 防抖监听
  final RxInt rxInt = 0.obs;
  set rxIntValue(int value) => rxInt.value = value;
  int get rxIntValue => rxInt.value;

  /// 页面控制器
  final RxInt _pageIndex = 0.obs;
  set pageIndex(int value) => _pageIndex.value = value;
  int get pageIndex => _pageIndex.value;

  /// 用户信息（json)
  final RxMap<String, dynamic> _userInfoMap = <String, dynamic>{}.obs;
  set userInfoMap(Map<String, dynamic> value) => _userInfoMap.value = value;
  Map<String, dynamic> get userInfoMap => _userInfoMap;

  final userInfo = UserInfoEntities.fromJson(UserInfoEntities.child).obs;
}
