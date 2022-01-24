import 'package:get/get.dart';

class CommunityState {
  /// 页面控制器
  final RxInt pageIndexRx = 0.obs;
  set pageIndex(int value) => pageIndexRx.value = value;
  int get pageIndex => pageIndexRx.value;
}
