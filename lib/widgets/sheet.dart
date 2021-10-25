import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/values/values.dart';

Future getImage() {
  var child = Container(
    width: double.infinity,
    height: 100.h,
    color: AppColors.mainBacground,
  );
  return Get.bottomSheet(
    child,
    backgroundColor: AppColors.secondBacground,
  );
}
