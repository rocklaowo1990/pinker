import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pinker/pages/application/community/library.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class HotView extends GetView<CommunityController> {
  const HotView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // loading时显示转圈圈
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
      () => controller.state.showListHot.isEmpty
          ? noData
          : getRefresher(
              controller: controller.refreshControllerHot,
              scrollController: controller.scrollController,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                        children: controller.state.showListHot
                            .map((index) => contentList(index))
                            .toList()),
                  ],
                ),
              ),
              onLoading: () {
                controller.onLoading(3);
              },
              onRefresh: () {
                controller.onRefresh(3);
              },
            ),
    );

    /// body
    Widget body = Obx(() => controller.state.isLoadingHot ? loading : _body);

    return Scaffold(
      body: body,
      backgroundColor: AppColors.mainBacground,
    );
  }
}
