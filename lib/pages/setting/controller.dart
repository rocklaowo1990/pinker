import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/setting/library.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/colors.dart';
import 'package:pinker/widgets/widgets.dart';

class SettingController extends GetxController {
  final state = LanguageState();

  /// 返回
  void handleGoSignBeforePage() {
    Get.back();
  }

  /// 去语言选择页面
  void handleGoLanguage() {
    Get.toNamed(AppRoutes.set + AppRoutes.language);
  }

  void _back() {
    Get.back();
  }

  void _signOut() async {
    Get.back();
    Future.delayed(const Duration(milliseconds: 200), () {
      goLoginPage();
    });
  }

  /// 退出登陆
  void handleSignOut() {
    getDialog(
      autoBack: true,
      child: DialogChild.alert(
        height: 100.h,
        child: Column(
          children: [
            getSpan('退出登陆', fontSize: 9.sp),
            SizedBox(height: 10.h),
            getSpan('是否确认退出登陆', color: AppColors.secondText),
          ],
        ),
        leftText: '取消',
        onPressedRight: _signOut,
        onPressedLeft: _back,
      ),
    );
  }

  /// 页面销毁
  @override
  void dispose() {
    super.dispose();
  }
}
