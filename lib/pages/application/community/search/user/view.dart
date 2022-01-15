import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/application/community/search/user/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class ContentListSearchUserView extends StatelessWidget {
  const ContentListSearchUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentListSearchUserController>(
        init: ContentListSearchUserController(),
        builder: (controller) {
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
            child: getButton(
              width: double.infinity,
              background: Colors.transparent,
              overlayColor: Colors.transparent,
              onPressed: controller.handleNoData,
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  SvgPicture.asset(
                    'assets/svg/error_4.svg',
                    width: 55.w,
                  ),
                  SizedBox(height: 6.h),
                  getSpan('暂无数据', color: AppColors.secondText),
                  SizedBox(height: 2.h),
                  getSpan('轻触屏幕重试', color: AppColors.secondText),
                ],
              ),
            ),
          );

          // 整体布局
          Widget _body = Obx(
            () => controller.searchController.state.recommendUserSearchList
                    .value.list.isEmpty
                ? noData
                : getRefresher(
                    controller: controller.refreshController,
                    child: ListView.builder(
                        controller: controller.scrollController,
                        itemCount: controller.searchController.state
                            .recommendUserSearchList.value.list.length,
                        itemBuilder: (BuildContext buildContext, int index) {
                          return getUserList(
                              controller
                                  .searchController
                                  .state
                                  .recommendUserSearchList
                                  .value
                                  .list[index]
                                  .avatar,
                              controller
                                  .searchController
                                  .state
                                  .recommendUserSearchList
                                  .value
                                  .list[index]
                                  .userName,
                              controller
                                  .searchController
                                  .state
                                  .recommendUserSearchList
                                  .value
                                  .list[index]
                                  .nickName,
                              color: AppColors.secondBacground,
                              intro: controller
                                  .searchController
                                  .state
                                  .recommendUserSearchList
                                  .value
                                  .list[index]
                                  .intro, buttonPressed: () {
                            getSubscribeBox(
                              userId: controller
                                  .searchController
                                  .state
                                  .recommendUserSearchList
                                  .value
                                  .list[index]
                                  .userId,
                              avatar: controller
                                  .searchController
                                  .state
                                  .recommendUserSearchList
                                  .value
                                  .list[index]
                                  .avatar,
                              userName: controller
                                  .searchController
                                  .state
                                  .recommendUserSearchList
                                  .value
                                  .list[index]
                                  .userName,
                              reSault: () {
                                controller.handSubscribeinfo(controller
                                    .searchController
                                    .state
                                    .recommendUserSearchList
                                    .value
                                    .list[index]);
                              },
                            );
                          },
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5.w, color: AppColors.line)));
                        }),
                    onLoading: controller.onLoading,
                    onRefresh: controller.onRefresh,
                  ),
          );

          /// body
          Widget body = Obx(() => controller.state.isLoading ? loading : _body);

          return Scaffold(
            body: body,
            backgroundColor: AppColors.mainBacground,
          );
        });
  }
}
