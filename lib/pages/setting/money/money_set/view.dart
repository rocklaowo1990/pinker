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
      getSpan('正在为玩家 ${controller.arguments.value.playerId} 参数设置'),
      line: AppColors.line,
      backgroundColor: AppColors.secondBacground,
    );

    Widget _setNumber(int number,
        {VoidCallback? subtraction, VoidCallback? addition}) {
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
              onPressed: subtraction,
              borderRadius: BorderRadius.all(Radius.circular(1000.h))),
          getSpan('$number'),
          getButton(
              child: Center(
                child: getSpan('+', fontSize: 17),
              ),
              width: 22.h,
              background: AppColors.line,
              height: 22.h,
              onPressed: addition,
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
            child: Obx(() =>
                _setNumber(controller.arguments.value.ji, subtraction: () {
                  controller.arguments.update((val) {
                    if (val!.ji > 0) val.ji--;
                  });
                }, addition: () {
                  controller.arguments.update((val) {
                    val!.ji++;
                  });
                })),
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
                      getSpan('玩家 ${controller.arguments.value.only_1}'),
                      SizedBox(
                        width: 70.w,
                        child: Obx(() =>
                            _setNumber(controller.arguments.value.only_1)),
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
                      getSpan('玩家 ${controller.arguments.value.only_2}'),
                      SizedBox(
                        width: 70.w,
                        child: Obx(() =>
                            _setNumber(controller.arguments.value.only_2)),
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
                      getSpan('玩家 ${controller.arguments.value.only_3}'),
                      SizedBox(
                        width: 70.w,
                        child: _setNumber(controller.arguments.value.only_3),
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
                          child: Obx(() =>
                              _setNumber(controller.arguments.value.ma_1))),
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
                          child: Obx(() =>
                              _setNumber(controller.arguments.value.ma_2))),
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
                          child: Obx(() =>
                              _setNumber(controller.arguments.value.ma_3))),
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
                          child: Obx(() =>
                              _setNumber(controller.arguments.value.ma_4))),
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
