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

    // 整体布局
    Widget _body = Obx(
      () => controller.state.subscribeList.value.list.isEmpty
          ? SingleChildScrollView(child: noData)
          : getRefresher(
              controller: controller.refreshController,
              child: ListView(
                children: controller.state.subscribeList.value.list
                    .map(
                      (item) => getUserList(
                        item.avatar,
                        item.userName,
                        item.nickName,
                        intro: item.intro,
                        button: const SizedBox(),
                      ),
                    )
                    .toList(),
              ),
              onLoading: () {
                controller.onLoading();
              },
              isFooter: controller.state.subscribeList.value.totalSize < 20
                  ? false
                  : true,
              onRefresh: () {
                controller.onRefresh();
              },
            ),
    );

    /// body
    Widget body = Obx(() => controller.state.isLoading ? loading : _body);

    return Scaffold(
      appBar: getAppBar(Obx(() => getSpan(
          '您正在订阅的用户（ ${controller.state.subscribeList.value.totalSize} 人）'))),
      body: body,
      backgroundColor: AppColors.mainBacground,
    );
  }
}
