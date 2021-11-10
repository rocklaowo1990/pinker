import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/widgets/verify/library.dart';
import 'package:pinker/widgets/widgets.dart';

class WidgetsVerifyController extends GetxController {
  /// 状态管理
  final state = WidgetsVerifyState();

  /// 输入框控制器
  final TextEditingController inputController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  /// 动画结束后继续动画
  void handleOnEnd() {
    state.opacity = state.opacity == 0 ? 1.0 : 0.0;
  }

  /// 点击六个格子的时候，弹出键盘
  void handleOnPressed() {
    focusNode.requestFocus();
  }

  void onChanged(
    text,
    Future<bool> Function(String text) isVerify,
    VoidCallback result,
  ) async {
    state.codeList = text.split(''); // 验证码转成数组
    state.opacity = 1; // 焦点绝对显示

    /// 验证码输完了以后才开始执行操作
    if (text.length >= 6) {
      focusNode.unfocus(); // 隐藏键盘
      getDialog(autoBack: true); // 弹出加载窗

      bool _isVerify = await isVerify(text);

      if (_isVerify) {
        Get.back();
        result();
      } else {
        inputController.text = '';
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
    super.onReady();

    /// 自动获取焦点
    await Future.delayed(const Duration(milliseconds: 200), () {
      focusNode.requestFocus();
    });

    /// 初始化焦点动画
    await Future.delayed(const Duration(milliseconds: 200), () {
      state.opacity = state.opacity == 0 ? 1.0 : 0.0;
    });
  }
}
