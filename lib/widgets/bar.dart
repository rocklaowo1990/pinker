import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
  return AppBar(
    title: title ?? SizedBox(width: 4.w, height: 4.w),
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
    leading: leading,
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
    title: SizedBox(
      height: 24.h,
      child: getInput(
        type: Lang.inputEmail.tr,
        controller: controller,
        focusNode: focusNode,
        prefixIcon: SizedBox(
          width: 10.h,
          height: 10.h,
          child: Center(
            child: SvgPicture.asset(
              'assets/svg/ic_sousuo.svg',
            ),
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
