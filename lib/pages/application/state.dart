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

  final userInfo = UserInfoEntities.fromJson(UserInfoEntities.child).obs;
}
