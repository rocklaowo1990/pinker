import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinker/api/user.dart';

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

  late Map<String, dynamic> userInfo;

  void handleMail() {
    Get.toNamed(AppRoutes.set);
  }

  void handleSetting() {
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
  }

  @override
  void onReady() async {
    super.onReady();

    /// 本地没有用户数据，请求用户的数据，然后保存至本地
    if (_userInfo == null) {
      ResponseEntity _info = await UserApi.info();
      if (_info.code == 200) {
        await StorageUtil().setJSON(storageUserInfoKey, _info.data);
        userInfo = _info.data;

        _getUserInfo(userInfo);
      } else {
        userInfo = {};
        _getUserInfo(userInfo);
        getSnackTop(_info.msg);
      }

      /// 本地有用户的数据，直接拿来用
    } else {
      _getUserInfo(_userInfo);
      userInfo = _userInfo;
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
