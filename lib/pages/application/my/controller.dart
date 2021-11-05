import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pinker/api/user.dart';
import 'package:pinker/entities/user_info.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/application/my/library.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class MyController extends GetxController {
  final MyState state = MyState();
  final ScrollController scrollController = ScrollController();

  /// 读取用户信息
  final _userInfo = StorageUtil().getJSON(storageUserInfoKey);

  void handleMail() {
    Get.toNamed(AppRoutes.set);
  }

  void handleSetting() {
    Get.toNamed(AppRoutes.set);
  }

  void _getUserInfo(Map<String, dynamic> info) {
    UserInfo userInfo = UserInfo.fromJson(info);
    state.avatar = userInfo.avatar ?? '';
    state.nickName = userInfo.nickName ?? '';
    state.userName = userInfo.userName ?? '';
    state.diamondBalance = userInfo.diamondBalance ?? 0;
    state.pCoinBalance = userInfo.pCoinBalance ?? 0;
    state.followCount = userInfo.followCount ?? 0;
    state.subChatCount = userInfo.subChatCount ?? 0;
  }

  @override
  void onInit() async {
    /// 本地没有用户数据，请求用户的数据，然后保存至本地
    if (_userInfo == null) {
      ResponseEntity _info = await UserApi.info();
      if (_info.code == 200) {
        await StorageUtil().setJSON(storageUserInfoKey, _info.data!);
        _getUserInfo(_info.data!);
      } else {
        getSnackTop(_info.msg);
      }

      /// 本地有用户的数据，直接拿来用
    } else {
      _getUserInfo(_userInfo);
    }

    super.onInit();
  }

  @override
  void onReady() {
    scrollController.addListener(() {
      state.opacity = scrollController.offset / 100;
      if (state.opacity > 1) state.opacity = 1;
      if (state.opacity < 0) state.opacity = 0;
    });
    super.onReady();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
