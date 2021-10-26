import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:pinker/values/colors.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

Widget _button(String text, ImageSource source, int index) {
  return getButton(
    child: getSpan(text),
    width: double.infinity,
    background: index == 1 ? AppColors.mainColor : AppColors.secondBacground,
    onPressed: () async {
      Get.back();
      var image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        getDialog(
          child: dialogImage(image),
          barrierColor: AppColors.mainBacground,
        );
      }
    },
  );
}

Future getImage() {
  return Get.bottomSheet(
    Container(
      height: 120.h,
      color: AppColors.mainBacground,
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          _button(
            '拍照',
            ImageSource.camera,
            1,
          ),
          SizedBox(height: 10.h),
          _button(
            '从相册里选取',
            ImageSource.gallery,
            2,
          ),
        ],
      ),
    ),
  );
}
