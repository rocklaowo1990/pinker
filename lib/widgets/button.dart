import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinker/values/values.dart';

Widget buttonWidget(
    {Color? background,
    required VoidCallback onPressed,
    Color? textColor,
    required String text,
    double? height}) {
  return SizedBox(
    width: double.infinity,
    height: height ?? 24.h,
    child: TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(186.5.w))),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        backgroundColor:
            MaterialStateProperty.all(background ?? AppColors.main),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? AppColors.white,
          fontSize: 8.sp,
        ),
      ),
    ),
  );
}
