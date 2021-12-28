import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

    Widget _setNumber(String number, int index) {
      late Widget textBox;
      late RxList<int> palyOnly;
      late RxList<int> ma;

      if (number == 'public') {
        textBox = Obx(() => getSpan(
            '${controller.moneyController.state.ji[controller.arguments]}'));
      } else if (number == 'payOnly') {
        if (controller.arguments == 0) {
          palyOnly = controller.moneyController.state.playerOnly_0;
        } else if (controller.arguments == 1) {
          palyOnly = controller.moneyController.state.playerOnly_1;
        } else if (controller.arguments == 2) {
          palyOnly = controller.moneyController.state.playerOnly_2;
        } else if (controller.arguments == 3) {
          palyOnly = controller.moneyController.state.playerOnly_3;
        }
        textBox = Obx(() => getSpan('${palyOnly[index]}'));
      } else if (number == 'ma') {
        if (controller.arguments == 0) {
          ma = controller.moneyController.state.ma_0;
        } else if (controller.arguments == 1) {
          ma = controller.moneyController.state.ma_1;
        } else if (controller.arguments == 2) {
          ma = controller.moneyController.state.ma_2;
        } else if (controller.arguments == 3) {
          ma = controller.moneyController.state.ma_3;
        }
        textBox = Obx(() => getSpan('${ma[index]}'));
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
                          .moneyController.state.ji[controller.arguments] >
                      0) {
                    controller.moneyController.state.ji[controller.arguments]--;
                  }
                } else if (number == 'payOnly') {
                  palyOnly[index]--;

                  if (controller.arguments == 0) {
                    palyOnly = controller.moneyController.state.playerOnly_0;
                    switch (index) {
                      case 0:
                        controller.moneyController.state.playerOnly_1[0]++;
                        break;
                      case 1:
                        controller.moneyController.state.playerOnly_2[0]++;

                        break;
                      default:
                        controller.moneyController.state.playerOnly_3[0]++;
                    }
                  } else if (controller.arguments == 1) {
                    palyOnly = controller.moneyController.state.playerOnly_1;
                    switch (index) {
                      case 0:
                        controller.moneyController.state.playerOnly_0[0]++;

                        break;
                      case 1:
                        controller.moneyController.state.playerOnly_2[1]++;

                        break;
                      default:
                        controller.moneyController.state.playerOnly_3[1]++;
                    }
                  } else if (controller.arguments == 2) {
                    palyOnly = controller.moneyController.state.playerOnly_2;
                    switch (index) {
                      case 0:
                        controller.moneyController.state.playerOnly_0[1]++;

                        break;
                      case 1:
                        controller.moneyController.state.playerOnly_1[1]++;

                        break;
                      default:
                        controller.moneyController.state.playerOnly_3[2]++;
                    }
                  } else {
                    palyOnly = controller.moneyController.state.playerOnly_3;
                    switch (index) {
                      case 0:
                        controller.moneyController.state.playerOnly_0[2]++;

                        break;
                      case 1:
                        controller.moneyController.state.playerOnly_1[2]++;

                        break;
                      default:
                        controller.moneyController.state.playerOnly_2[2]++;
                    }
                  }
                } else if (number == 'ma') {
                  if (ma[index] > 0) ma[index]--;
                }
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
                  controller.moneyController.state.ji[controller.arguments]++;
                } else if (number == 'payOnly') {
                  palyOnly[index]++;
                  if (controller.arguments == 0) {
                    palyOnly = controller.moneyController.state.playerOnly_0;
                    switch (index) {
                      case 0:
                        controller.moneyController.state.playerOnly_1[0]--;
                        break;
                      case 1:
                        controller.moneyController.state.playerOnly_2[0]--;

                        break;
                      default:
                        controller.moneyController.state.playerOnly_3[0]--;
                    }
                  } else if (controller.arguments == 1) {
                    palyOnly = controller.moneyController.state.playerOnly_1;
                    switch (index) {
                      case 0:
                        controller.moneyController.state.playerOnly_0[0]--;

                        break;
                      case 1:
                        controller.moneyController.state.playerOnly_2[1]--;

                        break;
                      default:
                        controller.moneyController.state.playerOnly_3[1]--;
                    }
                  } else if (controller.arguments == 2) {
                    palyOnly = controller.moneyController.state.playerOnly_2;
                    switch (index) {
                      case 0:
                        controller.moneyController.state.playerOnly_0[1]--;

                        break;
                      case 1:
                        controller.moneyController.state.playerOnly_1[1]--;

                        break;
                      default:
                        controller.moneyController.state.playerOnly_3[2]--;
                    }
                  } else {
                    palyOnly = controller.moneyController.state.playerOnly_3;
                    switch (index) {
                      case 0:
                        controller.moneyController.state.playerOnly_0[2]--;

                        break;
                      case 1:
                        controller.moneyController.state.playerOnly_1[2]--;

                        break;
                      default:
                        controller.moneyController.state.playerOnly_2[2]--;
                    }
                  }
                } else if (number == 'ma') {
                  ma[index]++;
                }
              },
              borderRadius: BorderRadius.all(Radius.circular(1000.h))),
        ],
      );
    }

    Widget setJi = Container(
      width: double.infinity,
      color: AppColors.secondBacground,
      padding: EdgeInsets.fromLTRB(9.w, 5.w, 9.w, 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getSpan('你拥有的鸡：'),
          SizedBox(
            width: 70.w,
            child: _setNumber('public', 0),
          ),
        ],
      ),
    );

    Widget setOnly = Container(
      width: double.infinity,
      color: AppColors.secondBacground,
      padding: EdgeInsets.fromLTRB(9.w, 9.w, 9.w, 9.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getSpan('你的单独收支：'),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(9.w, 3.w, 9.w, 3.w),
                  decoration: BoxDecoration(
                      color: AppColors.mainBacground,
                      borderRadius: BorderRadius.all(Radius.circular(4.w))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getSpan(
                          '玩家 ${controller.moneyController.payOnlyId[controller.arguments][0] + 1}'),
                      SizedBox(
                        width: 70.w,
                        child: _setNumber('payOnly', 0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(9.w, 3.w, 9.w, 3.w),
                  decoration: BoxDecoration(
                      color: AppColors.mainBacground,
                      borderRadius: BorderRadius.all(Radius.circular(4.w))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getSpan(
                          '玩家 ${controller.moneyController.payOnlyId[controller.arguments][1] + 1}'),
                      SizedBox(
                        width: 70.w,
                        child: _setNumber('payOnly', 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(9.w, 3.w, 9.w, 3.w),
                  decoration: BoxDecoration(
                      color: AppColors.mainBacground,
                      borderRadius: BorderRadius.all(Radius.circular(4.w))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getSpan(
                          '玩家 ${controller.moneyController.payOnlyId[controller.arguments][2] + 1}'),
                      SizedBox(
                        width: 70.w,
                        child: _setNumber('payOnly', 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    Widget ma = Container(
      width: double.infinity,
      color: AppColors.secondBacground,
      padding: EdgeInsets.fromLTRB(9.w, 9.w, 9.w, 9.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getSpan('你中的码号：'),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(9.w, 3.w, 9.w, 3.w),
                  decoration: BoxDecoration(
                      color: AppColors.mainBacground,
                      borderRadius: BorderRadius.all(Radius.circular(4.w))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getSpan('玩家 1'),
                      SizedBox(
                        width: 70.w,
                        child: _setNumber('ma', 0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(9.w, 3.w, 9.w, 3.w),
                  decoration: BoxDecoration(
                      color: AppColors.mainBacground,
                      borderRadius: BorderRadius.all(Radius.circular(4.w))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getSpan('玩家 2'),
                      SizedBox(
                        width: 70.w,
                        child: _setNumber('ma', 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(9.w, 3.w, 9.w, 3.w),
                  decoration: BoxDecoration(
                      color: AppColors.mainBacground,
                      borderRadius: BorderRadius.all(Radius.circular(4.w))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getSpan('玩家 3'),
                      SizedBox(
                        width: 70.w,
                        child: _setNumber('ma', 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(9.w, 3.w, 9.w, 3.w),
                  decoration: BoxDecoration(
                      color: AppColors.mainBacground,
                      borderRadius: BorderRadius.all(Radius.circular(4.w))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getSpan('玩家 4'),
                      SizedBox(
                        width: 70.w,
                        child: _setNumber('ma', 3),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    Widget body = ListView(
      children: [
        SizedBox(height: 10.h),
        setJi,
        SizedBox(height: 3.h),
        ma,
        SizedBox(height: 3.h),
        setOnly,
      ],
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: AppColors.mainBacground,
      body: body,
    );
  }
}
