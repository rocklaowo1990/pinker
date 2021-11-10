import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/lang/translation_service.dart';

import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/pages/frame/verify/library.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/widgets/widgets.dart';

class VerifyController extends GetxController {
  /// 遮罩控制器
  final FrameController frameController = Get.find();

  /// 状态管理
  final VerifyState state = VerifyState();

  /// 上一页传参
  final Map<String, dynamic> arguments = Get.arguments;

  /// 输入框控制器
  final TextEditingController inputController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void handleNext() {
    frameController.state.pageIndex = -1; // 下一页不需要返回
    Get.offAllNamed(AppRoutes.password, id: 1, arguments: arguments);
  }

  /// 请求验证码
  Future<bool> sendCode() async {
    /// 准备请求数据
    Map<String, String> data = {};

    if (arguments['accountType']! == '1') {
      data = {
        'mobile': arguments['account']!,
        'areaCode': arguments['areaCode']!,
        'entryType': arguments['entryType']!,
      };
    } else {
      data = {
        'email': arguments['account']!,
        'entryType': arguments['entryType']!,
      };
    }

    /// 请求服务器...
    ResponseEntity codeNumber = arguments['accountType']! == '1'
        ? await CommonApi.sendSms(data)
        : await CommonApi.sendEmail(data);

    /// 返回数据处理
    if (codeNumber.code == 200) {
      getSnackTop(
        Lang.codeSussful.tr,
        iconData: Icons.check_circle,
        iconColor: Colors.green,
      );
      frameController.state.sendTime = 60;
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
      'account': arguments['account'],
      'accountType': arguments['accountType'],
      'code': code,
      'entryType': arguments['entryType'],
    };
    ResponseEntity checkCode = await CommonApi.checkCode(data); // 弹窗停留时间

    if (checkCode.code == 200) {
      arguments['code'] = code;
      return true;
    } else {
      Get.back();
      getSnackTop(checkCode.msg);
      return false;
    }
  }

  /// 动画结束后继续动画
  void handleOnEnd() {
    state.opacity = state.opacity == 0 ? 1.0 : 0.0;
  }

  /// 点击六个格子的时候，弹出键盘
  void handleOnPressed() {
    focusNode.requestFocus();
  }

  /// 重新发送验证码
  void handleResendCode() {
    sendCode();
  }

  /// 验证码输入框文本改变时
  void handleOnChanged(String text) async {
    state.codeList = text.split(''); // 验证码转成数组
    state.opacity = 1; // 焦点绝对显示

    /// 验证码输完了以后才开始执行操作
    if (text.length >= 6) {
      focusNode.unfocus(); // 隐藏键盘
      getDialog(); // 弹出加载窗
      Map<String, dynamic> data = {
        'account': arguments['account'],
        'accountType': arguments['accountType'],
        'code': text,
        'entryType': arguments['entryType'],
      };
      ResponseEntity checkCode = await CommonApi.checkCode(data); // 弹窗停留时间

      Get.back(); // 隐藏弹窗

      /// 输入了正确的验证码
      if (checkCode.code == 200) {
        /// 传参数到下一页
        Map<String, String> data = {
          'account': arguments['account']!,
          'accountType': arguments['accountType']!,
          'birthday': arguments['birthday']!,
          'code': text,
          'areaCode': arguments['areaCode']!,
        };
        frameController.state.pageIndex = -1; // 下一页不需要返回
        Get.offAllNamed(AppRoutes.password, id: 1, arguments: data); // 去密码设置页

        /// 输入了错误的验证码
      } else {
        getSnackTop(checkCode.msg); //顶部弹出错误信息
        state.codeList = []; // 清空框框里的数字
        inputController.text = ''; // 清空验证码输入框

        /// 重置动画并获取焦点
        await Future.delayed(const Duration(milliseconds: 200));
        state.opacity = state.opacity == 0 ? 1.0 : 0.0;
        focusNode.requestFocus();
      }

      /// 验证码没输完
    } else {
      /// 重置动画
      await Future.delayed(const Duration(milliseconds: 500));
      state.opacity = state.opacity == 0 ? 1.0 : 0.0;
    }
  }

  @override
  void onReady() async {
    /// 发送验证码请求
    if (frameController.state.account != arguments['account']) {
      sendCode();
      frameController.state.account = arguments['account']!;
    } else {
      if (frameController.state.sendTime <= 0) {
        sendCode();
      }
    }
  }

  @override
  void dispose() {
    inputController.dispose();
    frameController.dispose();
    focusNode.dispose();

    super.dispose();
  }
}
