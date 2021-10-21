import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/frame/index.dart';
import 'package:pinker/pages/frame/register/index.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/widgets/widgets.dart';

class RegisterController extends GetxController {
  final frameController = Get.put(FrameController());

  final TextEditingController userRegisterController = TextEditingController();

  final FocusNode userRegisterFocusNode = FocusNode();

  final state = RegisterState();

  /// 关闭键盘
  void _unfocus() {
    userRegisterFocusNode.unfocus();
  }

  /// 输入框文本监听
  void _textListener() {
    state.isDissable = userRegisterController.text.isEmpty ? true : false;
  }

  /// 初始化
  @override
  void onInit() {
    super.onInit();
    userRegisterController.addListener(() {
      _textListener();
    });

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
    /// 关闭键盘
    _unfocus();

    /// 准备请求数据
    Map<String, String> data = {
      'mobile': userRegisterController.text,
      'areaCode': '86',
      'entryType': '1',
    };

    /// 请求服务器...
    ResponseEntity userProfile = await CommonApi.sendSms(data: data);

    debugPrint(
        'code:${userProfile.code} /n msg:${userProfile.msg} /n data:${userProfile.data}');
    await Future.delayed(const Duration(milliseconds: 200), () {
      userRegisterFocusNode.requestFocus();
    });
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
  void _onSure() {
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
      onPressed: _onSure,
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
