import 'package:get/get.dart';

class SetGroupState {
  /// 订阅分组
  final RxList _groupList = [].obs;
  set groupList(List value) => _groupList.value = value;
  List get groupList => _groupList;

  /// 正在请求数据
  final RxBool _isLoading = true.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;
}
