import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

/// 顶部弹窗封装
Future getSnackTop(String? msg, {bool? isError}) async {
  isError ??= true;
  Get.snackbar(
    msg ?? '',
    '',
    colorText: AppColors.mainText,
    titleText: getSpan(msg),
    messageText: const SizedBox(height: 0),
    icon: Icon(
      isError ? Icons.error : Icons.check_circle,
      size: 12.w,
      color: isError ? Colors.red : Colors.green,
    ),
    padding: EdgeInsets.only(
      left: 10.w,
      top: 8.h,
      bottom: 6.h,
    ),
    animationDuration: const Duration(milliseconds: 300),
    duration: const Duration(milliseconds: 1000),
  );
}
