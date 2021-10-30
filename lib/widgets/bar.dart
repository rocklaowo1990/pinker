import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinker/values/values.dart';

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
AppBar getMainBar() {
  return AppBar(
    title: SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.add,
            size: 13.w,
            color: AppColors.mainIcon,
          ),
          Icon(
            Icons.add,
            size: 13.w,
            color: AppColors.mainIcon,
          ),
        ],
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
