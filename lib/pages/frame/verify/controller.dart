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
  final FrameController frameController = Get.put(FrameController());

  /// 状态管理
  final VerifyState state = VerifyState();

  /// 上一页传参
  final Map<String, String> arguments = Get.arguments;

  /// 输入框控制器
  final TextEditingController inputController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  /// 请求验证码
  void _sendCode() async {
    /// 准备请求数据
    Map<String, String> data = {
      'mobile': arguments['mobile']!,
      'areaCode': arguments['areaCode']!,
      'entryType': arguments['entryType']!,
    };

    /// 请求服务器...
    ResponseEntity codeNumber = await CommonApi.sendSms(data: data);

    /// 返回数据处理
    if (codeNumber.code == 200) {
      getSnackTop(
        '验证码发送成功',
        iconData: Icons.check_circle,
        iconColor: Colors.green,
      );
      frameController.state.sendTime = 60;
    } else {
      /// 返回错误信息
      await Future.delayed(const Duration(milliseconds: 200), () {
        getSnackTop(codeNumber.msg);
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

  /// 重新发送验证码
  void handleResendCode() {
    _sendCode();
  }

  /// 验证码输入框文本改变时
  void handleOnChanged(String text) async {
    state.codeList = text.split(''); // 验证码转成数组
    state.opacity = 1; // 焦点绝对显示

    /// 验证码输完了以后才开始执行操作
    if (text.length >= 6) {
      focusNode.unfocus(); // 隐藏键盘
      getDialog(); // 弹出加载窗
      await Future.delayed(const Duration(milliseconds: 1000)); // 弹窗停留时间

      Get.back(); // 隐藏弹窗

      /// 输入了正确的验证码
      if (text == '123456') {
        /// 传参数到下一页
        Map<String, String> data = {
          'account': arguments['mobile']!,
          'accountType': arguments['entryType']!,
          'birthday': arguments['birthday']!,
          'code': '123456',
          'areaCode': arguments['areaCode']!,
        };

        frameController.state.pageIndex = -1; // 下一页不需要返回
        Get.offAllNamed(AppRoutes.password, id: 1, arguments: data); // 去密码设置页

        /// 输入了错误的验证码
      } else if (text.length == 6 && text != '123456') {
        getSnackTop(Lang.codeMsg.tr); //顶部弹出错误信息
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

    /// 自动获取焦点
    await Future.delayed(const Duration(milliseconds: 200), () {
      focusNode.requestFocus();
    });

    /// 判断一下倒计时，如果倒计时是0就请求验证码
    if (frameController.state.sendTime <= 0) _sendCode();

    /// 初始化焦点动画
    await Future.delayed(const Duration(milliseconds: 200), () {
      state.opacity = state.opacity == 0 ? 1.0 : 0.0;
    });
    // inputController.addListener(_addListener);
  }

  @override
  void dispose() {
    inputController.dispose();
    frameController.dispose();
    focusNode.dispose();

    super.dispose();
  }
}
