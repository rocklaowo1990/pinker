import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
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
  Map<String, dynamic> userInfo = {};
  final Map<String, dynamic>? _userInfo = StorageUtil().getJSON(
    storageUserInfoKey,
  );

  void handleMail() {
    Get.toNamed(AppRoutes.set);
  }

  void handleSetting() {
    Get.toNamed(AppRoutes.set);
  }

  @override
  void onInit() async {
    if (_userInfo == null) {
      /// 准备请求用户信息
      /// 请求到数据后，保存至本地
      /// 下次再登陆就不用再请求了
      ResponseEntity _info = await UserApi.info();
      if (_info.code == 200) {
        await StorageUtil().setJSON(storageUserInfoKey, _info.data);
        userInfo = _info.data!;
      } else {
        getSnackTop(_info.msg);
      }
    } else {
      userInfo = _userInfo!;
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
