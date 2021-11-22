import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/user.dart';
import 'package:pinker/entities/response.dart';

import 'package:pinker/widgets/user_list_page/library.dart';
import 'package:pinker/widgets/widgets.dart';

class UserListPageController extends GetxController {
  UserListPageController(this.type);

  /// 状态管理
  final state = UserListPageState();

  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final int? type;

  int page = 1;

  void handleListOnTap(item) {}

  @override
  void onReady() async {
    super.onReady();
    ResponseEntity responseEntity = await UserApi.settingUserList(type, page);
    if (responseEntity.code == 200) {
      if (responseEntity.data != null) {
        state.userList = responseEntity.data!['list'];
        print(state.userList);
        page++;
      }
    } else {
      getSnackTop(responseEntity.msg);
    }
  }
}
