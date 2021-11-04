import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/api/account.dart';
import 'package:pinker/entities/response.dart';
import 'package:pinker/lang/translation_service.dart';

import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/pages/frame/register/library.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class RegisterController extends GetxController {
  /// 遮罩控制器
  final FrameController frameController = Get.find();

  /// 输入框的控制器和焦点
  final TextEditingController userRegisterController = TextEditingController();
  final FocusNode userRegisterFocusNode = FocusNode();

  /// 状态管理
  final state = RegisterState();

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
        if (state.showTime.year > DateTime.now().year - 18) {
          state.isDissable = true;
        } else if (state.showTime.year == DateTime.now().year - 18 &&
            state.showTime.month > DateTime.now().month) {
          state.isDissable = true;
        } else if (state.showTime.year == DateTime.now().year - 18 &&
            state.showTime.month == DateTime.now().month &&
            state.showTime.day > DateTime.now().day) {
          state.isDissable = true;
        } else {
          state.isDissable = false;
        }
      },
      time: const Duration(milliseconds: 200),
    );
  }

  /// 下一步按钮，点击事件
  void handleNext() async {
    _unfocus(); // 失去焦点

    String number = '';

    if (state.isPhone) {
      String text = userRegisterController.text;
      number = text.substring(text.length - 2);
    } else {
      String text = userRegisterController.text;
      List<String> part_1 = text.split('@');
      List<String> part_2 = part_1[1].split('.');
      number = part_1[0].substring(part_1[0].length - 2) + '@' + part_2[0];
    }
    _dialogChile(number);
  }

  /// 区号选择
  void handleGoCodeList() async {
    if (userRegisterFocusNode.hasFocus) {
      _unfocus();
      await Future.delayed(const Duration(milliseconds: 200));
    }

    Get.toNamed(AppRoutes.codeList);
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
  void handleChangeRegister() async {
    _unfocus();
    userRegisterController.text = '';
    state.isPhone = !state.isPhone;
    Future.delayed(const Duration(milliseconds: 100), () {
      userRegisterFocusNode.requestFocus();
    });
  }

  /// 页面销毁
  @override
  void dispose() {
    frameController.dispose();
    userRegisterController.dispose();
    userRegisterFocusNode.dispose();

    super.dispose();
  }

  /// 发送验证码的确认弹窗
  Future _dialogChile(number) {
    return getDialog(
      child: DialogChild.alert(
        onPressedLeft: _edit,
        onPressedRight: _goCodePage,
        child: Column(
          children: [
            state.isPhone
                ? getSpan(Lang.registerVerifyPhone.tr, fontSize: 17)
                : getSpan(Lang.registerVerifyEmail.tr, fontSize: 17),
            SizedBox(height: 8.h),
            Expanded(
              child: SingleChildScrollView(
                child: state.isPhone
                    ? getSpan(
                        Lang.registerDialogPhone_1.tr +
                            number +
                            Lang.registerDialogPhone_2.tr,
                        fontSize: 15,
                        color: AppColors.secondText,
                        textAlign: TextAlign.center)
                    : getSpan(
                        Lang.registerDialogEmail_1.tr +
                            number +
                            Lang.registerDialogEmail_2.tr,
                        fontSize: 15,
                        color: AppColors.secondText,
                        textAlign: TextAlign.center),
              ),
              flex: 1,
            ),
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

    /// 准备检测账号是否重复
    Map<String, String> data = {
      'account': userRegisterController.text,
      'accountType': state.isPhone ? '1' : '2',
    };

    // var data2 = json.encoder(data);

    getDialog();

    ResponseEntity responseEntity = await AccountApi.checkAccount(data);

    Get.back();

    if (responseEntity.code == 200) {
      if (responseEntity.data!['status'] == 0) {
        /// 把注册数据传到下一页
        String bornYear = state.showTime.year.toString();

        String bornMonth = state.showTime.month.toString();
        if (bornMonth.length == 1) bornMonth = '0$bornMonth';

        String bornDay = state.showTime.day.toString();
        if (bornDay.length == 1) bornDay = '0$bornDay';

        String birthday = bornYear + bornMonth + bornDay;

        Map<String, String> arguments = {
          'account': userRegisterController.text,
          'areaCode': state.code,
          'entryType': '1',
          'birthday': birthday,
          'accountType': state.isPhone ? '1' : '2',
        };

        frameController.state.pageIndex++;
        Get.toNamed(AppRoutes.verify, id: 1, arguments: arguments);
      } else {
        getSnackTop(Lang.registerAllready.tr);
        userRegisterFocusNode.requestFocus();
      }
    } else {
      getSnackTop(responseEntity.msg);
    }
  }

  /// 输入框文本监听
  void _textListener() {
    if (userRegisterController.text.isEmpty) {
      state.isDissable = true;
    } else if (state.isPhone &&
        state.code == '86' &&
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

  /// 关闭键盘
  void _unfocus() {
    userRegisterFocusNode.unfocus();
  }
}
