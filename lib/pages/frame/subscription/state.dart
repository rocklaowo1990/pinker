import 'package:get/get.dart';

class SubscriptionState {
  /// 用户列表
  final RxList<dynamic> _userList = [].obs;
  set userList(value) => _userList.value = value;
  // ignore: invalid_use_of_protected_member
  List get userList => _userList.value;
}
