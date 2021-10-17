import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pinker/values/values.dart';

Future dateBottom({
  required String title,
}) {
  var button = Container(
    color: AppColors.backgroundLight,
    width: double.infinity,
    height: 25.h,
    child: TextButton(
      onPressed: () {
        Get.back();
      },
      child: Text(
        title,
        style: const TextStyle(color: AppColors.main),
      ),
    ),
  );
  var date = CupertinoDatePicker(
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
        Expanded(child: date),
      ],
    ),
  );
  return Get.bottomSheet(
    bottomsheet,
    backgroundColor: AppColors.inputHint,
  );
}
