import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/values/values.dart';

import 'package:pinker/widgets/widgets.dart';

Future getDateBox({
  DateTime? initialDateTime,
  required VoidCallback onPressed,
  required void Function(DateTime) onDateTimeChanged,
}) {
  /// 顶部的工具栏
  var title = getBottomBox(
    rightWidget: getButton(
      child: getSpan(Lang.sure.tr),
      onPressed: onPressed,
      width: 40.w,
      height: 18.h,
    ),
  );

  /// 日期选择器
  var dateBox = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.date,
    onDateTimeChanged: onDateTimeChanged,
    initialDateTime: initialDateTime ?? DateTime(1990, 1, 1),
    maximumYear: DateTime.now().year,
    minimumYear: DateTime.now().year - 100,
    dateOrder: DatePickerDateOrder.ymd,
  );

  /// 组合
  var body = SizedBox(
    height: 160.h,
    child: Column(
      children: [
        title,
        Expanded(child: dateBox),
      ],
    ),
  );

  /// 返回
  return Get.bottomSheet(
    body,
    backgroundColor: AppColors.dateBox,
    // isDismissible: false, 用户点击空白区域是否可以返回
  );
}
