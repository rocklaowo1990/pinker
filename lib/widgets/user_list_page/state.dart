import 'package:get/get.dart';

class UserListPageState {
  /// 列表数组
  final RxList _userList = [].obs;
  set userList(List value) => _userList.value = value;
  List get userList => _userList;
}
