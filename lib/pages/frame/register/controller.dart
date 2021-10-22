import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/frame/index.dart';
import 'package:pinker/pages/frame/register/index.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class RegisterController extends GetxController {
  /// 遮罩控制器
  final frameController = Get.put(FrameController());

  /// 输入框的控制器和焦点
  final TextEditingController userRegisterController = TextEditingController();
  final FocusNode userRegisterFocusNode = FocusNode();

  /// 状态管理
  final state = RegisterState();

  /// 关闭键盘
  void _unfocus() {
    userRegisterFocusNode.unfocus();
  }

  /// 输入框文本监听
  void _textListener() {
    if (userRegisterController.text.isEmpty) {
      state.isDissable = true;
    } else if (state.isPhone &&
        state.code == '+86' &&
        !isChinaPhoneLegal(userRegisterController.text)) {
      state.isDissable = true;
    } else if (!state.isPhone && !userRegisterController.text.isEmail) {
      state.isDissable = true;
    } else if (userRegisterController.text.length < 7) {
      state.isDissable = true;
    } else if (state.isPhone && !userRegisterController.text.isNum) {
      state.isDissable = true;
    } else {
      state.isDissable = false;
    }
  }

  /// 初始化
  @override
  void onInit() {
    super.onInit();
    userRegisterController.addListener(_textListener);

    /// 节流
    debounce(
      state.timeChangeRx,
      (date) {
        state.showTime = state.timeChange;
      },
      time: const Duration(milliseconds: 200),
    );
  }

  /// 下一步按钮，点击事件
  void handleNext() async {
    _unfocus(); // 失去焦点
    getDialog(
      child: dialogChild(
        onPressedLeft: _edit,
        onPressedRight: _goCodePage,
        child: Column(
          children: [
            state.isPhone
                ? getSpan('验证手机', size: 9.sp)
                : getSpan('验证邮箱', size: 9.sp),
            SizedBox(height: 8.h),
            state.isPhone
                ? getSpan('我们会以短信的形式将验证码发送到您尾号12的手机',
                    size: 8.sp, color: AppColors.secondText)
                : getSpan('我们会以短信的形式将验证码发送到您尾号12的邮箱',
                    size: 8.sp, color: AppColors.secondText),
          ],
        ),
      ),
      autoBack: true,
    );
  }

  void _edit() {
    Get.back();
    userRegisterFocusNode.requestFocus();
  }

  void _goCodePage() async {
    Get.back(); //这里是隐藏 dialog 窗口
    await Future.delayed(const Duration(milliseconds: 200));

    /// 准备请求数据
    Map<String, dynamic> data = {
      'mobile': userRegisterController.text,
      'areaCode': state.code,
      'entryType': state.isPhone ? '1' : '2',
    };

    debugPrint(data.toString());

    frameController.state.pageIndex++;
    Get.toNamed(
      AppRoutes.verify,
      id: 1,
      arguments: data,
    );
  }

  /// 区号选择
  void handleGoCodeList() async {
    if (userRegisterFocusNode.hasFocus) {
      _unfocus();
      await Future.delayed(const Duration(milliseconds: 200));
    }

    Get.toNamed(AppRoutes.codeList);
  }

  /// 时间确认按钮
  void _back() {
    Get.back();
  }

  /// 同意服务条款和隐私政策
  void handleAgreen() {
    state.isChooise = !state.isChooise;
  }

  /// 去服务条款页面
  void handleGoService() {}

  /// 去隐私政策页面
  void handleGoPrivacy() {}

  /// 时间选择时的事件
  void _timeChanged(DateTime dateTime) {
    state.timeChange = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    );
  }

  /// 点击生日输入框，调出日期选择器
  void birthChoice() {
    userRegisterFocusNode.unfocus();
    getDateBox(
      onPressed: _back,
      onDateTimeChanged: _timeChanged,
      initialDateTime: state.showTime,
    );
  }

  /// 切换注册方式
  void handleChangeRegister() {
    userRegisterController.text = '';
    state.isPhone = !state.isPhone;
    userRegisterFocusNode.requestFocus();
  }

  /// 页面销毁
  @override
  void dispose() {
    frameController.dispose();

    userRegisterController.dispose();
    userRegisterFocusNode.dispose();

    super.dispose();
  }
}
