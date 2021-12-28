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

    Widget _setNumber(String number) {
      late Widget textBox;
      if (number == 'public') {
        textBox = Obx(() => getSpan(
            '${controller.moneyController.state.public[controller.arguments]}'));
      } else {
        textBox = Obx(() => getSpan(
            '${controller.moneyController.state.public[controller.arguments]}'));
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getButton(
              child: Center(
                child: getSpan('-', fontSize: 17),
              ),
              width: 22.h,
              background: AppColors.line,
              height: 22.h,
              onPressed: () {
                if (number == 'public') {
                  if (controller
                          .moneyController.state.public[controller.arguments] >
                      0) {
                    controller
                        .moneyController.state.public[controller.arguments]--;
                  }
                }
                print('number');
                print(controller.moneyController.state.public);
              },
              borderRadius: BorderRadius.all(Radius.circular(1000.h))),
          textBox,
          getButton(
              child: Center(
                child: getSpan('+', fontSize: 17),
              ),
              width: 22.h,
              background: AppColors.line,
              height: 22.h,
              onPressed: () {
                if (number == 'public') {
                  controller
                      .moneyController.state.public[controller.arguments]++;
                }
                print(number);
                print(controller.moneyController.state.public);
              },
              borderRadius: BorderRadius.all(Radius.circular(1000.h))),
        ],
      );
    }

    Widget setJi = Container(
      height: 30.h,
      width: double.infinity,
      color: AppColors.secondBacground,
      padding: EdgeInsets.fromLTRB(9.w, 0, 9.w, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getSpan('你拥有的鸡：'),
          SizedBox(
            width: 70.w,
            child: _setNumber('public'),
          ),
        ],
      ),
    );

    Widget body = ListView(
      children: [
        SizedBox(height: 10.h),
        setJi,
      ],
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: AppColors.mainBacground,
      body: body,
    );
  }
}
