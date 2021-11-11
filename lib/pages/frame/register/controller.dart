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
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  /// 状态管理
  final state = RegisterState();

  /// 初始化
  @override
  void onInit() {
    super.onInit();
    textController.addListener(_textListener);

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

  /// 区号选择
  void handleGoCodeList() async {
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
    textController.text = '';
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
    Map<String, String> data = {
      'account': textController.text,
      'accountType': state.isPhone ? '1' : '2',
    };

    ResponseEntity responseEntity = await AccountApi.checkAccount(data);

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
          'account': textController.text,
          'areaCode': state.code,
          'entryType': '1',
          'birthday': birthday,
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
      }
    } else {
      getSnackTop(responseEntity.msg);
    }
  }

  /// 输入框文本监听
  void _textListener() {
    if (textController.text.isEmpty) {
      state.isDissable = true;
    } else if (state.isPhone &&
        state.code == '86' &&
        !isChinaPhoneLegal(textController.text)) {
      state.isDissable = true;
    } else if (!state.isPhone && !textController.text.isEmail) {
      state.isDissable = true;
    } else if (textController.text.length < 7) {
      state.isDissable = true;
    } else if (state.isPhone && !textController.text.isNum) {
      state.isDissable = true;
    } else {
      state.isDissable = false;
    }
  }

  /// 关闭键盘
  void _unfocus() {
    focusNode.unfocus();
  }
}
