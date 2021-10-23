import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/frame/index.dart';
import 'package:pinker/pages/frame/verify/index.dart';
import 'package:pinker/widgets/widgets.dart';

class VerifyController extends GetxController {
  /// 遮罩控制器
  final FrameController frameController = Get.put(FrameController());

  /// 状态管理
  final VerifyState state = VerifyState();

  /// 输入框控制器
  final TextEditingController inputController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  /// 发送验证码时间
  DateTime? sendTime;

  /// 验证码返回数据
  late ResponseEntity codeNumber;

  void _sendCode() async {
    /// 准备请求数据
    Map<String, String> data = Get.arguments;
    data.remove('birthday');

    /// 请求服务器...
    codeNumber = await CommonApi.sendSms(data: data);

    /// 返回数据处理
    if (codeNumber.code == 200) {
      getSnackTop(
        msg: '验证码发送成功',
        iconData: Icons.check_circle,
        iconColor: Colors.green,
      );
    } else {
      /// 返回错误信息
      await Future.delayed(const Duration(milliseconds: 200), () {
        getSnackTop(msg: codeNumber.msg);
      });
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

  /// 点击六个格子的时候，弹出键盘
  void handleOnChanged(String text) async {
    state.codeList = text.split('');
    state.opacity = 1;

    if (text == '123456') {
      debugPrint(Get.arguments.toString());

      /// 准备请求数据
      Map<String, String> data = {
        'account': Get.arguments['mobile']!,
        'accountType': Get.arguments['entryType']!,
        'birthday': Get.arguments['birthday']!,
        'code': '123456',
      };
      debugPrint(data.toString());
    } else if (text.length == 6 && text != '123456') {
      debugPrint(Get.arguments.toString());

      await Future.delayed(const Duration(milliseconds: 500));
      getSnackTop(msg: '验证码错误');
      state.codeList = [];
      inputController.text = '';
    }
    await Future.delayed(const Duration(milliseconds: 500));
    state.opacity = state.opacity == 0 ? 1.0 : 0.0;
  }

  /// 输入框控制器监听器
  // void _addListener() async {
  //   state.codeList = inputController.text.split('');
  //   state.opacity = 1;
  //   await Future.delayed(const Duration(milliseconds: 500));
  //   state.opacity = state.opacity == 0 ? 1.0 : 0.0;
  // }

  @override
  void onInit() async {
    super.onInit();
    _sendCode();
    await Future.delayed(const Duration(milliseconds: 200));
    focusNode.requestFocus();
    state.opacity = state.opacity == 0 ? 1.0 : 0.0;
    // inputController.addListener(_addListener);
  }

  @override
  void dispose() {
    inputController.dispose();
    focusNode.dispose();

    super.dispose();
  }
}
