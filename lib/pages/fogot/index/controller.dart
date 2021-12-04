import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/account.dart';
import 'package:pinker/entities/response.dart';
import 'package:pinker/entities/user_info.dart';

import 'package:pinker/pages/fogot/index/library.dart';

import 'package:pinker/pages/fogot/library.dart';

import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';

import 'package:pinker/widgets/widgets.dart';

class ForgotIndexController extends GetxController {
  /// 文本控制器
  final TextEditingController textController = TextEditingController();

  /// 焦点控制器
  final FocusNode focusNode = FocusNode();

  /// 状态控制器
  final ForgotIndexState state = ForgotIndexState();

  /// 主页面焦点
  final ForgotController forgotController = Get.find();

  /// 下一步
  void handleNext() async {
    getDialog();
    focusNode.unfocus();
    Map<String, dynamic> data = {'account': textController.text};

    ResponseEntity _userInfo = await AccountApi.verificateAccount(data);

    if (_userInfo.code == 200) {
      UserInfo userInfo = UserInfo.fromJson(_userInfo.data!);
      forgotController.userInfo.userId = userInfo.userId;
      forgotController.userInfo.userName = userInfo.userName;
      forgotController.userInfo.nickName = userInfo.nickName;
      forgotController.userInfo.avatar = userInfo.avatar;
      forgotController.userInfo.phone = userInfo.phone;
      forgotController.userInfo.email = userInfo.email;
      await futureMill(500);
      Get.back();

      if (textController.text.isNum) {
        forgotController.state.pageIndex = 3;
        forgotController.state.verifyType = 1;
        Get.offNamed(AppRoutes.forgotVerify, id: 3);
      } else if (textController.text.isEmail) {
        forgotController.state.pageIndex = 3;
        forgotController.state.verifyType = 2;
        Get.offNamed(AppRoutes.forgotVerify, id: 3);
      } else {
        forgotController.state.pageIndex++;
        Get.offNamed(AppRoutes.forgotInfo, id: 3);
      }
    } else {
      await futureMill(500);

      Get.back();
      textController.clear();
      getSnackTop(_userInfo.msg);
    }
  }

  @override
  void onReady() {
    super.onReady();
    focusNode.requestFocus();
    textController.addListener(() {
      String text = textController.text;
      state.isDissable = duCheckStringLength(text, 7) ? false : true;
    });
  }
}
