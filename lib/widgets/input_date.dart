import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinker/values/values.dart';

Widget inputDate({
  required VoidCallback onPressed,
  required String text,
}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(text),
    style: ButtonStyle(
      /// 按钮圆角
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(186.5.w))),

      /// 清空按钮的padding
      padding: MaterialStateProperty.all(
        EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
      ),

      /// 按钮背景色，默认主色
      backgroundColor: MaterialStateProperty.all(AppColors.inputFiled),
    ),
  );
}
