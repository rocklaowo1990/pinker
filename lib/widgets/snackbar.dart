import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/values/values.dart';

/// 顶部弹窗封装
void snackbar({
  String? title,
}) {
  return Get.snackbar(
    title ?? '',
    '',
    colorText: AppColors.mainText,
    titleText: Text(
      title ?? '',
      style: TextStyle(
        fontSize: 8.sp,
        color: AppColors.mainText,
      ),
    ),
    messageText: const SizedBox(height: 0),
    icon: Icon(
      Icons.error,
      size: 12.w,
      color: Colors.red,
    ),
    padding: EdgeInsets.only(
      left: 10.w,
      top: 8.h,
      bottom: 6.h,
    ),
  );
}
