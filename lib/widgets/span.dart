import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinker/values/colors.dart';

Widget span({
  required String text,
  double? size,
  Color? color,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size ?? 8.sp,
      color: color ?? AppColors.white,
    ),
  );
}
