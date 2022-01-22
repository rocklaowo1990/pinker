import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

/// 顶部弹窗封装
Future getSnackTop(
  String? msg, {
  bool? isError,
  int? time,
  String? message,
}) async {
  isError ??= true;
  Get.snackbar(
    '提示',
    msg ?? '',
    colorText: AppColors.mainText,
    titleText: getSpan(msg),
    messageText: SizedBox(height: 0.h),
    icon: Icon(
      isError ? Icons.error : Icons.check_circle,
      size: 16.w,
      color: isError ? Colors.red : Colors.green,
    ),
    padding: EdgeInsets.only(left: 10.w, top: 13.h, bottom: 6.h),
    animationDuration: const Duration(milliseconds: 300),
    duration: Duration(milliseconds: time ?? 1000),
  );
}
