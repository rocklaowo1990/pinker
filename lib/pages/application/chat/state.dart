import 'package:get/get.dart';

class ChatState {
  /// 底部页面状态
  final RxInt _pageIndex = 0.obs;
  set pageIndex(int value) => _pageIndex.value = value;
  int get pageIndex => _pageIndex.value;
}
