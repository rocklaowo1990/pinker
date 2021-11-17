import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pinker/values/colors.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

Future getImage(VoidCallback handleCamera, VoidCallback handleGallery) async {
  await Get.bottomSheet(
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: GestureDetector(onTap: () {
              Get.back();
            }),
          ),
        ),
        Container(
          color: AppColors.mainBacground,
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              _button(1, handleCamera),
              SizedBox(height: 10.h),
              _button(2, handleGallery),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _button(int index, VoidCallback onPressed) {
  return getButton(
    child: getSpan(index == 1 ? '拍照' : '从相册里选取'),
    width: double.infinity,
    padding: EdgeInsets.only(top: 7.h, bottom: 7.h),
    background: index == 1 ? AppColors.mainColor : AppColors.secondBacground,
    onPressed: onPressed,
  );
}
