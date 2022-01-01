import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/api/account.dart';
import 'package:pinker/entities/response.dart';
import 'package:pinker/lang/translation_service.dart';

import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/pages/frame/register/library.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';

import 'package:pinker/widgets/widgets.dart';

class RegisterController extends GetxController {
  /// 遮罩控制器
  final FrameController frameController = Get.find();

  /// 输入框的控制器和焦点
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  /// 状态管理
  final state = RegisterState();

  /// 初始化
  @override
  void onReady() {
    super.onReady();
    focusNode.requestFocus();
    textController.addListener(_textListener);

    /// 节流
    debounce(
      state.timeChangeRx,
      (DateTime date) {
        state.showTime = state.timeChange;
        _textListener();
      },
      time: const Duration(milliseconds: 200),
    );
  }

  /// 下一步按钮，点击事件
  void handleNext() async {
    focusNode.unfocus();
    String number = '';

    if (state.isPhone) {
      number = getLastTwo(textController.text);
    } else {
      number = getEmailHide(textController.text);
    }

    getDialog(
      child: DialogChild.alert(
        onPressedLeft: _edit,
        onPressedRight: _goCodePage,
        title: state.isPhone
            ? Lang.registerVerifyPhone.tr
            : Lang.registerVerifyEmail.tr,
        content: state.isPhone
            ? Lang.registerDialogPhone_1.tr +
                number +
                Lang.registerDialogPhone_2.tr
            : Lang.registerDialogEmail_1.tr +
                number +
                Lang.registerDialogEmail_2.tr,
      ),
      autoBack: true,
    );
  }

  /// 区号选择
  void handleGoCodeList() async {
    // focusNode.unfocus();

    var result = await Get.toNamed(
      AppRoutes.codeList,
      arguments: state.code,
    );

    if (result != null) state.code = result;
  }

  /// 同意服务条款和隐私政策
  void handleAgreen() {
    state.isChooise = !state.isChooise;
  }

  /// 去服务条款页面
  void handleGoService() {}

  /// 去隐私政策页面
  void handleGoPrivacy() {}

  /// 时间确认按钮
  void _back() {
    Get.back();
  }

  /// 时间选择时的事件
  void _timeChanged(DateTime dateTime) {
    state.timeChange = dateTime;
  }

  /// 点击生日输入框，调出日期选择器
  void birthChoice() {
    _unfocus();
    getDateBox(
      onPressed: _back,
      onDateTimeChanged: _timeChanged,
      initialDateTime: state.showTime,
    );
  }

  /// 切换注册方式
  void handleChangeRegister() async {
    _unfocus();
    textController.clear();
    state.isPhone = !state.isPhone;
    await futureMill(100);

    focusNode.requestFocus();
  }

  /// 页面销毁
  @override
  void dispose() {
    frameController.dispose();
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _edit() {
    Get.back();
    focusNode.requestFocus();
  }

  void _goCodePage() async {
    Get.back();
    getDialog();

    /// 准备检测账号是否重复
    Map<String, dynamic> data = {
      'account': textController.text,
      'accountType': state.isPhone ? '1' : '2',
    };

    ResponseEntity responseEntity = await AccountApi.checkAccount(data);

    if (responseEntity.code == 200) {
      if (responseEntity.data['status'] == 0) {
        // 把注册数据传到下一页
        // String bornYear = state.showTime.year.toString();

        // String bornMonth = state.showTime.month.toString();
        // if (bornMonth.length == 1) bornMonth = '0$bornMonth';

        // String bornDay = state.showTime.day.toString();
        // if (bornDay.length == 1) bornDay = '0$bornDay';

        // String birthday = bornYear + bornMonth + bornDay;

        Map<String, dynamic> arguments = {
          'account': textController.text,
          'areaCode': state.code,
          'entryType': '1',
          'birthday': state.showTime.microsecondsSinceEpoch,
          'accountType': state.isPhone ? '1' : '2',
        };

        frameController.state.pageIndex++;
        await futureMill(500);

        Get.back();

        Get.toNamed(AppRoutes.verify, id: 1, arguments: arguments);
      } else {
        await futureMill(500);

        Get.back();
        getSnackTop(Lang.registerAllready.tr);
        focusNode.requestFocus();
      }
    } else {
      Get.back();
      getSnackTop(responseEntity.msg);
    }
  }

  /// 输入框文本监听
  void _textListener() {
    /// 输入框为空时
    if (textController.text.isEmpty) {
      state.isAccountPass = true;

      /// 手机注册 且 区号是86时，判断是否为中国手机号码
    } else if (state.isPhone &&
        state.code == '86' &&
        !isChinaPhone(textController.text)) {
      state.isAccountPass = true;

      /// 邮箱注册 且 输入的不是邮箱格式
    } else if (!state.isPhone && !textController.text.isEmail) {
      state.isAccountPass = true;

      /// 输入框长度小于 7
    } else if (textController.text.length < 7) {
      state.isAccountPass = true;

      /// 手机注册 且 输入的不是纯数字
    } else if (state.isPhone && !textController.text.isNum) {
      state.isAccountPass = true;

      /// 其他
    } else {
      state.isAccountPass = false;
    }
  }

  /// 关闭键盘
  void _unfocus() {
    focusNode.unfocus();
  }
}
