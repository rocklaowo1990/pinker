import 'package:get/get.dart';

class UserListPageState {
  /// 列表数组
  final RxList _userList = [].obs;
  set userList(List value) => _userList.value = value;
  List get userList => _userList;

  /// 正在请求数据
  final RxBool _isLoading = true.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;
}
