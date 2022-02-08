import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/application/community/sub/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class ContentListSubView extends StatelessWidget {
  const ContentListSubView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentListSubController>(
        init: ContentListSubController(),
        builder: (controller) {
          // loading时显示转圈圈
          Widget loading = getLoadingIcon();

          // 没有数据的时候，显示暂无数据
          // 没有数据的时候，显示暂无数据
          Widget noData = Column(
            children: [
              Container(
                padding: EdgeInsets.all(40.w),
                color: AppColors.secondBacground,
                width: double.infinity,
                child: Column(
                  children: [
                    getTitle('什么？还没有推文？'),
                    SizedBox(height: 20.h),
                    getSpan(
                      '这条空白的时间线将很快消失，开始关注用户，您再次回到这里将看到他们的推文',
                      textAlign: TextAlign.center,
                      color: AppColors.secondText,
                    ),
                    SizedBox(height: 32.h),
                    Padding(
                      padding: EdgeInsets.only(left: 40.w, right: 40.w),
                      child: getButtonMain(
                        child: getSpan('寻找值得订阅的用户'),
                        onPressed: controller.handleRemmondMore,
                      ),
                    )
                  ],
                ),
              ),
            ],
          );

          // 整体布局
          Widget _body = Obx(
            () => controller.applicationController.state.contentListSub.value
                    .list.isEmpty
                ? noData
                : getRefresher(
                    controller: controller.refreshController,
                    child: ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.applicationController.state
                          .contentListSub.value.list.length,
                      itemBuilder: (BuildContext buildContext, int index) {
                        return getContentListView(
                            controller
                                .applicationController.state.contentListSub,
                            index);
                      },
                    ),
                    onLoading: controller.onLoading,
                    onRefresh: controller.onRefresh,
                  ),
          );

          /// body
          Widget body = Obx(() =>
              controller.applicationController.state.isLoadingSub
                  ? loading
                  : _body);

          return Scaffold(
            body: body,
            backgroundColor: AppColors.mainBacground,
          );
        });
  }
}
