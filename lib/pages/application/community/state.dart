import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';

class CommunityState {
  /// 页面控制器
  final RxInt _pageIndex = 0.obs;
  set pageIndex(int value) => _pageIndex.value = value;
  int get pageIndex => _pageIndex.value;

  /// 推文列表:最新
  final RxList<ListElement> _showListNew = <ListElement>[].obs;
  set showListNew(value) => _showListNew.value = value;
  RxList<ListElement> get showListNew => _showListNew;

  /// 正在请求数据:最新
  final RxBool _isLoadingNew = true.obs;
  set isLoadingNew(bool value) => _isLoadingNew.value = value;
  bool get isLoadingNew => _isLoadingNew.value;

  /// 推文列表:最热
  final RxList<ListElement> _showListHot = <ListElement>[].obs;
  set showListHot(value) => _showListHot.value = value;
  RxList<ListElement> get showListHot => _showListHot;

  /// 正在请求数据：最热
  final RxBool _isLoadingHot = true.obs;
  set isLoadingHot(bool value) => _isLoadingHot.value = value;
  bool get isLoadingHot => _isLoadingHot.value;
}
