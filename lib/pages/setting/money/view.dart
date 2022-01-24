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
    AppBar appBar = getAppBar(getSpan('麻将结算系统'),
        lineColor: AppColors.line,
        backgroundColor: AppColors.secondBacground,
        actions: [
          getButton(
            child: getSpan('重置'),
            width: 70,
            background: Colors.transparent,
            onPressed: controller.handleReset,
          ),
        ]);

    Widget playerBox(
      Rx<MoneySystems> player,
    ) {
      return getButton(
        width: double.infinity,
        padding: EdgeInsets.all(9.w),
        background: AppColors.secondBacground,
        borderRadius: BorderRadius.all(Radius.circular(8.w)),
        onPressed: () {
          controller.handleSet(player);
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
                        '玩家 ${player.value.playerId}  (被买：${player.value.beBuy})')),
                  ],
                ),
                Obx(() => player.value.resault == 0
                    ? getSpan('+0', fontSize: 20, color: AppColors.secondText)
                    : player.value.resault > 0
                        ? getSpan('+${player.value.resault}',
                            fontSize: 20, color: AppColors.errro)
                        : getSpan('${player.value.resault}',
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
                    getSpan('你拥有的公共鸡：', color: AppColors.secondText),
                    Obx(() => getSpan(
                          '${player.value.ji}',
                          color: player.value.ji > 0
                              ? AppColors.errro
                              : AppColors.secondText,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getSpan('你的单独收支：', color: AppColors.secondText),
                    Row(
                      children: [
                        Obx(() => getSpan(
                            '${player.value.onlyId_1}(${player.value.only_1})',
                            color: player.value.only_1 > 0
                                ? AppColors.errro
                                : player.value.only_1 < 0
                                    ? Colors.green
                                    : AppColors.secondText)),
                        getSpan(' , ', color: AppColors.secondText),
                        Obx(() => getSpan(
                            '${player.value.onlyId_2}(${player.value.only_2})',
                            color: player.value.only_2 > 0
                                ? AppColors.errro
                                : player.value.only_2 < 0
                                    ? Colors.green
                                    : AppColors.secondText)),
                        getSpan(' , ', color: AppColors.secondText),
                        Obx(() => getSpan(
                            '${player.value.onlyId_3}(${player.value.only_3})',
                            color: player.value.only_3 > 0
                                ? AppColors.errro
                                : player.value.only_3 < 0
                                    ? Colors.green
                                    : AppColors.secondText)),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getSpan('你买的码号：', color: AppColors.secondText),
                    Row(
                      children: [
                        Obx(() => getSpan(
                              '1(${player.value.ma_1})',
                              color: player.value.ma_1 > 0
                                  ? AppColors.errro
                                  : AppColors.secondText,
                            )),
                        getSpan(' , ', color: AppColors.secondText),
                        Obx(() => getSpan(
                              '2(${player.value.ma_2})',
                              color: player.value.ma_2 > 0
                                  ? AppColors.errro
                                  : AppColors.secondText,
                            )),
                        getSpan(' , ', color: AppColors.secondText),
                        Obx(() => getSpan(
                              '3(${player.value.ma_3})',
                              color: player.value.ma_3 > 0
                                  ? AppColors.errro
                                  : AppColors.secondText,
                            )),
                        getSpan(' , ', color: AppColors.secondText),
                        Obx(() => getSpan(
                              '4(${player.value.ma_4})',
                              color: player.value.ma_4 > 0
                                  ? AppColors.errro
                                  : AppColors.secondText,
                            )),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    /// body 布局
    Widget body = Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  playerBox(controller.state.player_1),
                  SizedBox(height: 6.h),
                  playerBox(controller.state.player_2),
                  SizedBox(height: 6.h),
                  playerBox(controller.state.player_3),
                  SizedBox(height: 6.h),
                  playerBox(controller.state.player_4),
                ],
              ),
            ),
          ),
          SizedBox(height: 9.w),
          Obx(() => getButtonMain(
                child: getSpan('开始结算'),
                background: controller.state.isReset
                    ? AppColors.secondBacground
                    : AppColors.mainColor,
                onPressed:
                    controller.state.isReset ? null : controller.handleResault,
              )),
        ],
      ),
    );
    return Scaffold(
      appBar: appBar,
      backgroundColor: AppColors.mainBacground,
      body: body,
    );
  }
}
