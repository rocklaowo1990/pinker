import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

/// 顶部弹窗封装
void getSnackTop({
  String? msg,
  IconData? iconData,
  Color? iconColor,
}) {
  return Get.snackbar(
    msg ?? '',
    '',
    colorText: AppColors.mainText,
    titleText: getSpan(msg ?? ''),
    messageText: const SizedBox(height: 0),
    icon: Icon(
      iconData ?? Icons.error,
      size: 12.w,
      color: iconColor ?? Colors.red,
    ),
    padding: EdgeInsets.only(
      left: 10.w,
      top: 8.h,
      bottom: 6.h,
    ),
  );
}
