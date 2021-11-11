import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/lang/translation_service.dart';

import 'package:pinker/pages/fogot/library.dart';
import 'package:pinker/pages/fogot/password/view.dart';
import 'package:pinker/pages/fogot/verify/library.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';

class ForgotVerifyController extends GetxController {
  /// 状态控制器
  final ForgotVerifyState state = ForgotVerifyState();

  /// 主页面焦点
  final ForgotController forgotController = Get.find();

  void handleNext() {
    forgotController.pageController.animateToPage(
      forgotController.state.pageCount.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  /// 请求验证码
  Future<bool> sendCode() async {
    /// 准备请求数据
    Map<String, dynamic> data = {
      'userId': forgotController.userInfo.userId!,
      'verifyType': forgotController.state.verifyType,
    };

    /// 请求服务器...
    ResponseEntity codeNumber = await CommonApi.sendSmsByType(data);

    /// 返回数据处理
    if (codeNumber.code == 200) {
      getSnackTop(
        Lang.codeSussful.tr,
        iconData: Icons.check_circle,
        iconColor: Colors.green,
      );

      forgotController.state.sendTime = 60;
      return true;
    } else {
      /// 返回错误信息
      await Future.delayed(const Duration(milliseconds: 200), () {
        getSnackTop(codeNumber.msg);
      });
      return false;
    }
  }

  /// 验证验证码
  Future<bool> isVerify(String code) async {
    Map<String, dynamic> data = {
      'code': code,
      'verifyType': forgotController.state.verifyType,
      'userId': forgotController.userInfo.userId!,
    };
    ResponseEntity checkCode = await CommonApi.checkCodeByType(data); // 弹窗停留时间

    if (checkCode.code == 200) {
      forgotController.publicData['code'] = code;
      forgotController.state.pageCount.add(const ForgotPasswordView());
      forgotController.state.pageIndex++;
      await futureMill(500);

      return true;
    } else {
      await futureMill(500);

      Get.back();
      getSnackTop(checkCode.msg);
      return false;
    }
  }

  @override
  void onReady() async {
    super.onReady();
    await sendCode();
  }
}
