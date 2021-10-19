import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinker/values/values.dart';

/// appBar
AppBar getAppBar({
  Widget? title,
  Widget? leading,
  List<Widget>? actions,
  Color? backgroundColor,
  double? elevation,
}) {
  return AppBar(
    title: title ?? SizedBox(width: 4.w, height: 4.w),
    backgroundColor: backgroundColor ?? Colors.transparent,
    foregroundColor: AppColors.mainText,
    elevation: elevation ?? 0,
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
