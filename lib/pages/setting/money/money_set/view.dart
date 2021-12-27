import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/setting/money/money_set/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class MoneySetView extends GetView<MoneySetController> {
  const MoneySetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar
    AppBar appBar = getAppBar(
      getSpan('正在为玩家 ${controller.arguments + 1} 参数设置'),
      line: AppColors.line,
      backgroundColor: AppColors.secondBacground,
    );

    Widget _switchHu = getButtonList(
        height: 30.h,
        title: '胡',
        onPressed: controller.handleOnChangedNoValue,
        iconRight: Obx(() => Switch(
              value: controller.state.isHu == 0 ? false : true,
              onChanged: controller.handleOnChanged,
            )));

    Widget _switchTing = getButtonList(
        height: 30.h,
        title: '听',
        onPressed: controller.handleOnChangedNoValue,
        iconRight: Obx(() => Switch(
              value: controller.state.isHu == 0 ? false : true,
              onChanged: controller.handleOnChanged,
            )));

    Widget _switchGang = getButtonList(
        height: 30.h,
        title: '杠',
        onPressed: controller.handleOnChangedNoValue,
        iconRight: Obx(() => Switch(
              value: controller.state.isHu == 0 ? false : true,
              onChanged: controller.handleOnChanged,
            )));

    Widget body = ListView(
      children: [
        SizedBox(height: 10.h),
        _switchHu,
        SizedBox(height: 1.h),
        _switchTing,
        SizedBox(height: 1.h),
        _switchGang,
      ],
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: AppColors.mainBacground,
      body: body,
    );
  }
}
