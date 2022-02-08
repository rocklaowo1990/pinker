import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void screenInit(BuildContext context) {
  ScreenUtil.init(
    BoxConstraints(
      maxWidth: Get.width,
      maxHeight: Get.height,
    ),
    designSize: Size(Get.width, Get.height),
    context: context,
    minTextAdapt: true,
    orientation: Orientation.portrait,
  );
}
