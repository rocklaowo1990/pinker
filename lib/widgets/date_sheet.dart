import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/values/values.dart';

import 'package:pinker/widgets/widgets.dart';

/// 底部弹出的日期选择器
/// 注册那里用了一下
/// 如果其他地方需要用的话，可以用调用该方法
Future getDateBox({
  DateTime? initialDateTime,
  required VoidCallback onPressed,
  required void Function(DateTime) onDateTimeChanged,
}) async {
  /// 顶部的工具栏
  var title = getBottomBox(
    // leftWidget: getSpan(
    //   '未年满18周岁禁止注册和使用本产品',
    //   color: AppColors.secondText,
    // ),
    rightWidget: getButtonSheet(
      child: getSpan(Lang.sure.tr),
      onPressed: onPressed,
    ),
  );

  DateTime dateTime = DateTime.now();

  /// 日期选择器
  var dateBox = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.date,
    onDateTimeChanged: onDateTimeChanged,
    initialDateTime: initialDateTime ?? DateTime(1990, 1, 1),
    maximumYear: DateTime.now().year - 18,
    minimumYear: DateTime.now().year - 100,
    maximumDate: DateTime(dateTime.year - 18, dateTime.month, dateTime.day - 1),
    dateOrder: DatePickerDateOrder.ymd,
  );

  /// 组合
  var body = SizedBox(
    height: 260,
    child: SafeArea(
      top: false,
      child: Column(
        children: [
          title,
          Expanded(child: dateBox),
        ],
      ),
    ),
  );

  /// 返回
  Get.bottomSheet(
    body,
    backgroundColor: AppColors.mainText,
    // isDismissible: false, 用户点击空白区域是否可以返回
  );
}
