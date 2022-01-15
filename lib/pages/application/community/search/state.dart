import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';

class SearchState {
  /// 是否现实搜索按钮
  final RxBool _isShowSearch = false.obs;
  set isShowSearch(bool value) => _isShowSearch.value = value;
  bool get isShowSearch => _isShowSearch.value;

  /// 是否已经搜素完毕
  final RxBool _isSearchEnd = false.obs;
  set isSearchEnd(bool value) => _isSearchEnd.value = value;
  bool get isSearchEnd => _isSearchEnd.value;

  final userData = UserListEntities.fromJson(UserListEntities.child).obs;
  final textData = <String>[].obs;

  /// 推文列表-照片
  final contentListSearchPhoto =
      ContentListEntities.fromJson(ContentListEntities.child).obs;

  /// 推文列表-视频
  final contentListSearchVideo =
      ContentListEntities.fromJson(ContentListEntities.child).obs;

  /// 推文列表-最新
  final contentListSearchNew =
      ContentListEntities.fromJson(ContentListEntities.child).obs;

  /// 推文列表-最热
  final contentListSearchHot =
      ContentListEntities.fromJson(ContentListEntities.child).obs;

  /// 推文列表-限免
  final contentListSearchFree =
      ContentListEntities.fromJson(ContentListEntities.child).obs;

  /// 用户列表
  final recommendUserSearchList =
      UserListEntities.fromJson(UserListEntities.child).obs;

  /// 页面控制器
  final RxInt _pageIndex = 0.obs;
  set pageIndex(int value) => _pageIndex.value = value;
  int get pageIndex => _pageIndex.value;
}
