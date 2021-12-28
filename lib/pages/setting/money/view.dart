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
      late RxList<int> palyOnly;
      late RxList<int> ma;

      if (id == 0) {
        palyOnly = controller.state.playerOnly_0;
        ma = controller.state.ma_0;
      } else if (id == 1) {
        palyOnly = controller.state.playerOnly_1;
        ma = controller.state.ma_1;
      } else if (id == 2) {
        palyOnly = controller.state.playerOnly_2;
        ma = controller.state.ma_2;
      } else if (id == 3) {
        palyOnly = controller.state.playerOnly_3;
        ma = controller.state.ma_3;
      }
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
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getSpan('你拥有的鸡：', color: AppColors.secondText),
                    Obx(() => getSpan(
                          '${controller.state.ji[id]}',
                          color: AppColors.secondText,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getSpan('你的单独收支：', color: AppColors.secondText),
                    Obx(() => getSpan(
                          '${controller.payOnlyId[id][0] + 1}(${palyOnly[0]}), ${controller.payOnlyId[id][1] + 1}(${palyOnly[1]}), ${controller.payOnlyId[id][2] + 1}(${palyOnly[2]})',
                          color: AppColors.secondText,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getSpan('你中的码号：', color: AppColors.secondText),
                    Obx(() => getSpan(
                          '1(${ma[0]}), 2(${ma[1]}), 3(${ma[2]}), 4(${[
                            ma[3]
                          ]})',
                          color: AppColors.secondText,
                        )),
                  ],
                ),
              ],
            ),
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
              onPressed: controller.handleResault,
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
