import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/button.dart';

Future dateBottom({
  required String date,
  required VoidCallback onPressed,
}) {
  var button = Container(
    padding: EdgeInsets.only(right: 10.w, left: 10.w),
    color: AppColors.secondBacground,
    width: double.infinity,
    height: 30.h,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            date,
            style: TextStyle(
              color: AppColors.mainText,
              fontSize: 8.sp,
            ),
          ),
        ),
        buttonWidget(
          width: 40.w,
          height: 18.h,
          onPressed: onPressed,
          text: Lang.sure.tr,
        ),
      ],
    ),
  );
  var dateBox = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.date,
    onDateTimeChanged: (e) {},
    initialDateTime: DateTime(1990, 1, 1),
    maximumYear: DateTime.now().year,
    minimumYear: DateTime.now().year - 100,
    dateOrder: DatePickerDateOrder.ymd,
  );
  var bottomsheet = SizedBox(
    height: 160.h,
    child: Column(
      children: [
        button,
        Expanded(child: dateBox),
      ],
    ),
  );
  return Get.bottomSheet(
    bottomsheet,
    backgroundColor: AppColors.inputHint,
  );
}
