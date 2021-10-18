import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

/// 顶部弹窗封装
void snackError({
  String? msg,
  IconData? iconData,
}) {
  return Get.snackbar(
    msg ?? '',
    '',
    colorText: AppColors.mainText,
    titleText: span(text: msg ?? ''),
    messageText: const SizedBox(height: 0),
    icon: Icon(
      iconData ?? Icons.error,
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
