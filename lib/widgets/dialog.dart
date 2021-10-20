import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/values/values.dart';

Future getDialog({
  Widget? child,
  bool? autoBack,
  double? width,
  double? height,
}) {
  /// loading
  Widget loading = Center(
    child: Container(
      width: width ?? 40.w,
      height: height ?? 40.w,
      decoration: BoxDecoration(
        color: AppColors.secondBacground,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Center(
        child: SizedBox(
          width: 9.w,
          height: 9.w,
          child: CircularProgressIndicator(
            backgroundColor: AppColors.mainIcon,
            color: AppColors.mainColor,
            strokeWidth: 1.w,
          ),
        ),
      ),
    ),
  );
  return Get.dialog(
    child ?? loading,
    barrierDismissible: autoBack ?? false,
  );
}
