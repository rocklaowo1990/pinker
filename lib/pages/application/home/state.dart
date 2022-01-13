import 'package:get/get.dart';

class HomeState {
  /// 页面控制器
  final RxInt _pageIndex = 0.obs;
  set pageIndex(int value) => _pageIndex.value = value;
  int get pageIndex => _pageIndex.value;
}
