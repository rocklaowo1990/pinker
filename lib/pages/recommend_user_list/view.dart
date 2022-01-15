import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:pinker/pages/recommend_user_list/library.dart';

import 'package:pinker/utils/utils.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class RecommendUserListView extends GetView<RecommendUserListController> {
  const RecommendUserListView({Key? key}) : super(key: key);

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
      () => controller
              .applicationController.state.recommendUserList.value.list.isEmpty
          ? SingleChildScrollView(child: noData)
          : getRefresher(
              controller: controller.refreshController,
              child: ListView(
                children: controller
                    .applicationController.state.recommendUserList.value.list
                    .map(
                      (item) => getUserList(
                        item.avatar,
                        item.userName,
                        item.nickName,
                        intro: item.intro,
                        color: AppColors.secondBacground,
                        border: Border(
                          bottom: BorderSide(
                            width: 0.5.w,
                            color: AppColors.line,
                          ),
                        ),
                        buttonPressed: () {
                          getSubscribeBox(
                            userId: item.userId,
                            avatar: item.avatar,
                            userName: item.nickName,
                            reSault: () async {
                              await getRecommendList(pageNo: 1);
                              await getContentListAll();
                            },
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
              onLoading: () {
                controller.onLoading();
              },
              onRefresh: () {
                controller.onRefresh();
              },
            ),
    );

    /// body
    Widget body = Obx(() => controller.state.isLoading ? loading : _body);

    return Scaffold(
      appBar: getAppBar(
        getSpan('推荐订阅'),
        backgroundColor: AppColors.secondBacground,
        lineColor: AppColors.line,
      ),
      body: body,
      backgroundColor: AppColors.mainBacground,
    );
  }
}
