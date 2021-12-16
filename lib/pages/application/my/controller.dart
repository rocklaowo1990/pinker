import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinker/api/user.dart';

import 'package:pinker/entities/entities.dart';
import 'package:pinker/global.dart';

import 'package:pinker/pages/application/my/library.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class MyController extends GetxController {
  final MyState state = MyState();
  final ScrollController scrollController = ScrollController();

  void handleMail() {
    Get.toNamed(AppRoutes.set);
  }

  void handleSetting() {
    /// 读取用户信息
    var userInfo = StorageUtil().getJSON(storageUserInfoKey);
    userInfo ??= <String, dynamic>{};
    UserInfo _userInfo = UserInfo.fromJson(userInfo);

    Get.toNamed(AppRoutes.set, arguments: _userInfo);
  }

  void _getUserInfo(Map<String, dynamic> info) {
    UserInfo _userInfo = UserInfo.fromJson(info);
    state.avatar = _userInfo.avatar;
    state.nickName = _userInfo.nickName;
    state.userName = _userInfo.userName;
    state.diamondBalance = _userInfo.diamondBalance;
    state.pCoinBalance = _userInfo.pCoinBalance;
    state.followCount = _userInfo.followCount;
    state.subChatCount = _userInfo.subChatCount;
    state.userId = _userInfo.userId;
    state.phone = _userInfo.phone;
    state.email = _userInfo.email;
  }

  @override
  void onReady() async {
    super.onReady();

    /// 本地没有用户数据，请求用户的数据，然后保存至本地
    if (Global.isHadUserInfo) {
      /// 读取用户信息
      final _userInfo = StorageUtil().getJSON(storageUserInfoKey);
      _getUserInfo(_userInfo);
    } else {
      ResponseEntity _info = await UserApi.info();
      if (_info.code == 200) {
        await StorageUtil().setJSON(storageUserInfoKey, _info.data);
        _getUserInfo(_info.data);
      } else {
        getSnackTop(_info.msg);
      }
    }
    scrollController.addListener(() {
      state.opacity = scrollController.offset / 100;
      if (state.opacity > 1) state.opacity = 1;
      if (state.opacity < 0) state.opacity = 0;
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
