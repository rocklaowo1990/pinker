import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:pinker/pages/setting/money/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class MoneyView extends GetView<MoneyController> {
  const MoneyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar 右侧的设置按钮
    Widget settingBox = getButton(
      child: SvgPicture.asset('assets/svg/icon_setting.svg'),
      background: Colors.transparent,
      width: 30.w,
      height: 30.w,
    );

    /// appBar
    AppBar appBar = getAppBar(getSpan('麻将结算系统'),
        line: AppColors.line,
        backgroundColor: AppColors.secondBacground,
        actions: [settingBox]);

    Widget playerBox({
      required int id,
    }) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(9.w),
        decoration: BoxDecoration(
            color: AppColors.secondBacground,
            borderRadius: BorderRadius.all(Radius.circular(8.w))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/avatar_default.svg',
                      height: 30,
                    ),
                    SizedBox(width: 10.w),
                    getSpan('玩家：${id + 1}'),
                  ],
                ),
                Obx(() => controller.state.resault[id] == 0
                    ? getSpan('+0', fontSize: 20, color: AppColors.secondText)
                    : controller.state.resault[id] > 0
                        ? getSpan('+${controller.state.resault[id]}',
                            fontSize: 20, color: AppColors.errro)
                        : getSpan('${controller.state.resault[id]}',
                            fontSize: 20, color: Colors.green)),
              ],
            ),
            SizedBox(height: 10.h),
            Obx(() => controller.state.play[id].isEmpty
                ? getButton(
                    child: getSpan('请为玩家添加参数'),
                    width: double.infinity,
                    background: AppColors.line,
                    height: 22.h,
                    onPressed: () {
                      controller.handleSet(id);
                    },
                  )
                : Row()),
          ],
        ),
      );
    }

    /// body 布局
    Widget body = SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(9.w),
        child: Column(
          children: [
            playerBox(id: 0),
            SizedBox(height: 6.h),
            playerBox(id: 1),
            SizedBox(height: 6.h),
            playerBox(id: 2),
            SizedBox(height: 6.h),
            playerBox(id: 3),
            SizedBox(height: 10.h),
            getButton(
              child: getSpan('开始结算'),
              width: double.infinity,
              height: 22.h,
            )
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: appBar,
      backgroundColor: AppColors.mainBacground,
      body: body,
    );
  }
}
