import 'package:get/get.dart';

class HomeState {
  /// 页面控制器
  final RxInt pageIndexRx = 0.obs;
  set pageIndex(int value) => pageIndexRx.value = value;
  int get pageIndex => pageIndexRx.value;

  /// 页面控制器
  final _isShow = false.obs;
  set isShow(value) => _isShow.value = value;
  get isShow => _isShow.value;
}
