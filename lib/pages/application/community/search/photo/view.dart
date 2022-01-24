import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/application/community/search/photo/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class ContentListSearchPhotoView extends StatelessWidget {
  const ContentListSearchPhotoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentListSearchPhotoController>(
        init: ContentListSearchPhotoController(),
        builder: (controller) {
// loading时显示转圈圈
          Widget loading = getLoadingIcon();

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
            () => controller.searchController.state.contentListSearchPhoto.value
                    .list.isEmpty
                ? noData
                : getRefresher(
                    controller: controller.refreshController,
                    child: ListView.builder(
                        controller: controller.scrollController,
                        itemCount: controller.searchController.state
                            .contentListSearchPhoto.value.list.length,
                        itemBuilder: (BuildContext buildContext, int index) {
                          return getContentListView(
                              controller.searchController.state
                                  .contentListSearchPhoto,
                              index);
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
