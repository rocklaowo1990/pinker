import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

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

Widget dialogChild({
  double? width,
  double? height,
  Widget? child,
  VoidCallback? onPressedLeft,
  VoidCallback? onPressedRight,
  String? leftText,
  String? rightText,
}) {
  return Center(
    child: Container(
      width: width ?? 120.w,
      height: height ?? 90.w,
      decoration: BoxDecoration(
        color: AppColors.secondBacground,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: child,
            ),
            flex: 1,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 0.5.h, color: AppColors.line),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: getButton(
                      child: Text(leftText ?? '编辑'),
                      width: double.infinity,
                      height: 30.h,
                      background: Colors.transparent,
                      radius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.w),
                      ),
                      onPressed: onPressedLeft),
                ),
                Container(
                  width: 0.5.w,
                  height: 30.h,
                  color: AppColors.line,
                ),
                Expanded(
                  child: getButton(
                    child: Text(rightText ?? '确认'),
                    height: 30.h,
                    width: double.infinity,
                    background: Colors.transparent,
                    radius: BorderRadius.only(
                      bottomRight: Radius.circular(8.w),
                    ),
                    onPressed: onPressedRight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
