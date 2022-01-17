import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/subscribe_list/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SubscribeListView extends GetView<SubscribeListController> {
  const SubscribeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget loading = Center(
        child: Column(children: [
      SizedBox(height: 40.h),
      SizedBox(
          width: 9.w,
          height: 9.w,
          child: CircularProgressIndicator(
              backgroundColor: AppColors.mainIcon,
              color: AppColors.mainColor,
              strokeWidth: 1.w)),
      SizedBox(height: 6.h),
      getSpan('加载中...', color: AppColors.secondText),
    ]));

    // 没有数据的时候，显示暂无数据
    Widget noData = Center(
      child: Column(
        children: [
          SizedBox(height: 40.h),
          SvgPicture.asset(
            'assets/svg/error_4.svg',
            width: 55.w,
          ),
          SizedBox(height: 6.h),
          getSpan('暂无数据', color: AppColors.secondText),
        ],
      ),
    );

    Widget _list({
      required String avatar,
      required String title,
      required String secondTitle,
      required int amount,
      required int endDate,
    }) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(9.w),
        decoration: BoxDecoration(
            color: AppColors.secondBacground,
            border: Border(
                bottom: BorderSide(color: AppColors.line, width: 0.5.w))),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: getUserAvatar(avatar, title, secondTitle),
                ),
                getButton(
                  width: 40.w,
                  child: getSpan('续费'),
                )
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                getSpan('订阅价格：', color: AppColors.secondText),
                const Spacer(),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/icon_diamond.svg',
                      height: 15,
                    ),
                    SizedBox(width: 3.w),
                    getSpan('$amount'),
                  ],
                )
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                getSpan('自动续费：', color: AppColors.secondText),
                const Spacer(),
                SizedBox(
                  height: 20,
                  width: 30,
                  child: Obx(
                    () => Switch(
                      value: controller.state.enable == 0 ? false : true,
                      onChanged: controller.handleOnChanged,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                getSpan('到期时间：', color: AppColors.secondText),
                const Spacer(),
                getSpan(
                    '${DateTime.fromMillisecondsSinceEpoch(endDate).year}-${DateTime.fromMillisecondsSinceEpoch(endDate).month}-${DateTime.fromMillisecondsSinceEpoch(endDate).day}'),
              ],
            ),
          ],
        ),
      );
    }

    Widget haveData = getRefresher(
      controller: controller.refreshController,
      child: Obx(
        () => ListView(
          children: controller.state.subscribeList.value.list
              .map(
                (item) => _list(
                  avatar: item.avatar,
                  title: item.nickName,
                  secondTitle: item.userName,
                  amount: item.amount,
                  endDate: item.endDate,
                ),
              )
              .toList(),
        ),
      ),
      onLoading: () {
        controller.onLoading();
      },
      isFooter:
          controller.state.subscribeList.value.totalSize < 20 ? false : true,
      onRefresh: () {
        controller.onRefresh();
      },
    );

    // 整体布局
    Widget _body = Obx(
      () => controller.state.subscribeList.value.list.isEmpty
          ? SingleChildScrollView(child: noData)
          : haveData,
    );

    /// body
    Widget body = Obx(() => controller.state.isLoading ? loading : _body);

    return Scaffold(
      appBar: getAppBar(
        Obx(() => getSpan(
            '您正在订阅的用户（ ${controller.state.subscribeList.value.totalSize} 人）')),
        backgroundColor: AppColors.secondBacground,
        lineColor: AppColors.line,
      ),
      body: body,
      backgroundColor: AppColors.mainBacground,
    );
  }
}
