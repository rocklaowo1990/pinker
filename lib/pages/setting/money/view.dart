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
    /// appBar
    AppBar appBar = getAppBar(
      getSpan('麻将结算系统'),
      line: AppColors.line,
      backgroundColor: AppColors.secondBacground,
    );

    Widget playerBox({
      required int id,
    }) {
      return getButton(
        width: double.infinity,
        padding: EdgeInsets.all(9.w),
        background: AppColors.secondBacground,
        borderRadius: BorderRadius.all(Radius.circular(8.w)),
        onPressed: () {
          controller.handleSet(id);
        },
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
                    SizedBox(width: 6.w),
                    Obx(() => getSpan(
                        '玩家 ${id + 1}  (单：${controller.state.resaultOnly[id]})')),
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
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              height: 1,
              color: AppColors.line,
            ),
            SizedBox(height: 6.h),
            Obx(() => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getSpan('所有人要给你的数量：', color: AppColors.secondText),
                        getSpan(
                          '${controller.state.public[id]}',
                          color: AppColors.secondText,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getSpan('你的单独支出：', color: AppColors.secondText),
                        getSpan(
                          '${controller.state.payOnly[id][0]['id']! + 1}(${controller.state.payOnly[id][0]['number']}), ${controller.state.payOnly[id][1]['id']! + 1}(${controller.state.payOnly[id][2]['number']}), ${controller.state.payOnly[id][2]['id']! + 1}(${controller.state.payOnly[id][2]['number']})',
                          color: AppColors.secondText,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getSpan('你的单独收入：', color: AppColors.secondText),
                        getSpan(
                          '${controller.state.shouOnly[id][0]['id']! + 1}(${controller.state.shouOnly[id][0]['number']}), ${controller.state.shouOnly[id][1]['id']! + 1}(${controller.state.shouOnly[id][2]['number']}), ${controller.state.shouOnly[id][2]['id']! + 1}(${controller.state.shouOnly[id][2]['number']})',
                          color: AppColors.secondText,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getSpan('你中的码：', color: AppColors.secondText),
                        getSpan(
                          '1(${controller.state.ma[id][0]}), 2(${controller.state.ma[id][1]}), 3(${controller.state.ma[id][2]}), 4(${controller.state.ma[id][3]})',
                          color: AppColors.secondText,
                        ),
                      ],
                    ),
                  ],
                )),
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
