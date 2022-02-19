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
  final contentListSub =
      ContentListEntities.fromJson(ContentListEntities.child).obs;

  /// 首页金刚区和轮播图
  final homeSwiperKing = HomeSwiperKing.fromJson(HomeSwiperKing.child).obs;

  /// 活动列表
  final homeActivity = HomeActivityList.fromJson(HomeActivityList.child).obs;

  /// 推文列表-最新
  final contentListNew =
      ContentListEntities.fromJson(ContentListEntities.child).obs;

  /// 推文列表-最热
  final contentListHot =
      ContentListEntities.fromJson(ContentListEntities.child).obs;

  /// 推文列表-限免
  final contentListFree =
      ContentListEntities.fromJson(ContentListEntities.child).obs;

  /// 推荐用户列表
  final recommendUserList =
      UserListEntities.fromJson(UserListEntities.child).obs;

  /// 加载中--首页
  final RxBool _isLoadingSub = true.obs;
  set isLoadingSub(bool value) => _isLoadingSub.value = value;
  bool get isLoadingSub => _isLoadingSub.value;

  /// 加载中--限免
  final RxBool _isLoadingFree = true.obs;
  set isLoadingFree(bool value) => _isLoadingFree.value = value;
  bool get isLoadingFree => _isLoadingFree.value;
}
