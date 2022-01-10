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

  /// 个人信息
  final userInfo = UserInfoEntities.fromJson(UserInfoEntities.child).obs;

  /// 推文列表-首页
  final contentListHome =
      ContentListEntities.fromJson(ContentListEntities.child).obs;

  /// 推文列表-最新
  final contentListNew =
      ContentListEntities.fromJson(ContentListEntities.child).obs;

  /// 推文列表-最热
  final contentListHot =
      ContentListEntities.fromJson(ContentListEntities.child).obs;

  /// 推文列表-限免
  final contentListFree =
      ContentListEntities.fromJson(ContentListEntities.child).obs;

  /// 加载中
  final RxBool _isLoading = true.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;
}
