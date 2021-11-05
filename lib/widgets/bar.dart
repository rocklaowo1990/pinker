import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

/// appBar
AppBar getAppBar(
  Widget? title, {
  Widget? leading,
  List<Widget>? actions,
  Color? backgroundColor,
  double? elevation,
  PreferredSizeWidget? bottom,
}) {
  /// appBar 左侧的返回按钮
  Widget leadingDefault = getButton(
    child: SvgPicture.asset('assets/svg/icon_back.svg'),
    onPressed: () {
      Get.back();
    },
    background: Colors.transparent,
  );

  return AppBar(
    title: title,
    backgroundColor: backgroundColor ?? Colors.transparent,
    foregroundColor: AppColors.mainText,
    elevation: elevation ?? 0,
    shadowColor: AppColors.thirdIcon,
    bottom: bottom,
    centerTitle: true,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
    leading: leading ?? leadingDefault,
    actions: actions,
  );
}

/// appBar
AppBar getMainBar({required Widget left, required Widget right}) {
  return AppBar(
    title: left,
    actions: [
      right,
      const SizedBox(),
    ],
    backgroundColor: AppColors.mainBacground,
    elevation: 0.5.w,
    shadowColor: AppColors.thirdIcon,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
}

/// appBar
AppBar getSearchBar({
  required TextEditingController controller,
  required FocusNode focusNode,
}) {
  return AppBar(
    title: getInput(
      height: 24.h,
      type: Lang.inputEmail.tr,
      controller: controller,
      focusNode: focusNode,
      prefixIcon: SizedBox(
        width: 10.h,
        height: 10.h,
        child: Center(
          child: SvgPicture.asset(
            'assets/svg/icon_search_2.svg',
          ),
        ),
      ),
    ),
    backgroundColor: AppColors.mainBacground,
    elevation: 0.5.w,
    shadowColor: AppColors.thirdIcon,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
}
