import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/account.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/frame/frame.dart';
import 'package:pinker/widgets/widgets.dart';

class RegisterController extends GetxController {
  final frameController = Get.put(FrameController());

  final TextEditingController userRegisterController = TextEditingController();

  final FocusNode userRegisterFocusNode = FocusNode();

  /// 节流变量
  Rx<DateTime> dateChanged = DateTime(1990, 1, 1).obs;

  /// 时间
  Rx<DateTime> dateTime = DateTime(1990, 1, 1).obs;

  /// 判断是手机注册 还是 邮箱注册
  RxBool phoneRegister = true.obs;

  /// 按钮专用禁用状态
  RxBool buttonDisable = true.obs;

  /// 注册方式

  /// 关闭键盘
  void _unfocus() {
    userRegisterFocusNode.unfocus();
  }

  /// 输入框文本监听
  void _textListener() {
    buttonDisable.value = userRegisterController.text.isEmpty ? true : false;
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
      dateChanged,
      (date) {
        dateTime.value = dateChanged.value;
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
    UserLoginResponseEntity userProfile = await AccountApi.sendSms(data: data);

    debugPrint(
        'code:${userProfile.code} /n msg:${userProfile.msg} /n data:${userProfile.data}');
    await Future.delayed(const Duration(milliseconds: 200), () {
      userRegisterFocusNode.requestFocus();
    });
  }

  /// 时间确认按钮
  void _onSure() {
    Get.back();
  }

  /// 时间选择时的事件
  void _timeChanged(DateTime dateTime) {
    dateChanged.value = DateTime(
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
      initialDateTime: dateTime.value,
    );
  }

  /// 切换注册方式
  void handleChangeRegister() {
    userRegisterController.text = '';
    phoneRegister.value = !phoneRegister.value;
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
