import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/account.dart';
import 'package:pinker/entities/response.dart';
import 'package:pinker/entities/user_info.dart';

import 'package:pinker/pages/fogot/index/library.dart';
import 'package:pinker/pages/fogot/info/library.dart';
import 'package:pinker/pages/fogot/library.dart';
import 'package:pinker/widgets/dialog.dart';
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
    Map<String, dynamic> data = {'account': textController.text};
    textController.text = '';

    getDialog();

    ResponseEntity _userInfo = await AccountApi.verificateAccount(data);

    if (_userInfo.code == 200) {
      forgotController.state.pageCount.add(const ForgotInfoView());
      forgotController.state.pageIndex++;

      UserInfo userInfo = UserInfo.fromJson(_userInfo.data!);
      forgotController.userInfo.userId = userInfo.userId;
      forgotController.userInfo.userName = userInfo.userName;
      forgotController.userInfo.nickName = userInfo.nickName;
      forgotController.userInfo.avatar = userInfo.avatar;
      forgotController.userInfo.phone = userInfo.phone;
      forgotController.userInfo.email = userInfo.email;

      Get.back();

      await Future.delayed(const Duration(milliseconds: 300));

      forgotController.pageController.animateToPage(
        forgotController.state.pageCount.length - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      Get.back();
      getSnackTop(_userInfo.msg);
    }
  }

  @override
  void onInit() {
    super.onInit();
    textController.addListener(() {
      if (textController.text.length < 7) {
        state.isDissable = true;
      } else {
        state.isDissable = false;
      }
    });
  }
}
