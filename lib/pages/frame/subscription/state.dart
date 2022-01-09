import 'package:get/get.dart';

import 'package:pinker/entities/user_list.dart';

class SubscriptionState {
  /// 用户列表
  final Rx<UserListEntities> userList =
      UserListEntities.fromJson(UserListEntities.child).obs;
}
