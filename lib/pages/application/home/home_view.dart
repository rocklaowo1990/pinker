import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:card_swiper/card_swiper.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/application/home/library.dart';
import 'package:pinker/routes/app_pages.dart';

import 'package:pinker/values/colors.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        var list = ['首页'];
        Widget left = getTabBar(
          list,
          controller.state.pageIndexRx,
          controller: controller.tabController,
        );

        // // appbar 右侧按钮
        // Widget right = getButton(
        //   child: SvgPicture.asset(
        //     'assets/svg/icon_mail_3.svg',
        //   ),
        //   background: Colors.transparent,
        //   width: 33.h,
        //   height: 33.h,
        //   onPressed: controller.handleMail,
        // );

        // AppBar
        AppBar appBar = getMainBar(
          left: left,
          right: const SizedBox(),
        );

        // loading时显示转圈圈
        Widget loading = getLoadingIcon();

        // 没有数据的时候，显示暂无数据
        Widget noDataList = Container(
          padding: EdgeInsets.all(32.w),
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
              getButtonMain(
                child: getSpan('寻找值得订阅的用户'),
                onPressed: controller.handleRemmondMore,
              )
            ],
          ),
        );

        Widget swiper = SizedBox(
          height: 150.h,
          width: double.infinity,
          // color: AppColors.secondBacground,
          child: Obx(
            () => Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.thirdIcon,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.w),
                    ),
                  ),
                );
              },
              itemCount: controller.applicationController.state.homeSwiperKing
                  .value.carousel.length,
              viewportFraction: 0.85,
              scale: 0.9,
              pagination: const SwiperPagination(
                builder: SwiperPagination.dots,
              ),
            ),
          ),
        );

        Widget _warp(
          String url,
          String text,
        ) {
          return getButton(
            background: Colors.transparent,
            overlayColor: Colors.transparent,
            onPressed: () {},
            width: Get.width / 4,
            child: Column(
              children: [
                getNetworkImageBox(
                  url,
                  width: 60.w,
                  height: 60.w,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.w),
                  ),
                ),
                SizedBox(height: 16.h),
                getSpan(text),
              ],
            ),
          );
        }

        Widget _activity({
          required String name,
          required String avatar,
          required int joinCount,
          required int endDate,
        }) {
          DateTime end = DateTime.fromMillisecondsSinceEpoch(endDate);
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.secondBacground,
              border: Border(
                top: BorderSide(
                  width: 0.5.w,
                  color: AppColors.line,
                ),
              ),
            ),
            child: Row(
              children: [
                getNetworkImageBox(
                  avatar,
                  width: 150.w,
                  height: 100.w,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.w),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: getSpan(
                          name,
                          fontSize: 16.sp,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        width: double.infinity,
                        child: getSpanMain('$joinCount 人参与'),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        width: double.infinity,
                        child: getSpan('活动时间：截止到${end.month}月${end.day}日',
                            color: AppColors.secondText),
                      ),
                      // SizedBox(
                      //   width: double.infinity,
                      //   child:
                      //       getSpan('09/09-09/09', color: AppColors.secondText),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        Widget activity = Obx(
          () => Column(
            children:
                controller.applicationController.state.homeActivity.value.list
                    .map(
                      (e) => _activity(
                        name: e.name,
                        avatar: e.avatar,
                        endDate: e.endDate,
                        joinCount: e.joinCount,
                      ),
                    )
                    .toList(),
          ),
        );

        Widget warp = Obx(
          () => Container(
            color: AppColors.secondBacground,
            padding: EdgeInsets.fromLTRB(0, 20.h, 0, 20.h),
            child: Wrap(
              runSpacing: 20.h,
              children: controller.applicationController.state.homeSwiperKing
                          .value.category.length <=
                      8
                  ? controller
                      .applicationController.state.homeSwiperKing.value.category
                      .map((e) => _warp(e.pic, e.name))
                      .toList()
                  : controller
                      .applicationController.state.homeSwiperKing.value.category
                      .sublist(0, 8)
                      .map((e) => _warp(e.pic, e.name))
                      .toList(),
            ),
          ),
        );

        Widget recommend = Container(
          decoration: const BoxDecoration(
              color: AppColors.secondBacground,
              border:
                  Border(bottom: BorderSide(color: AppColors.line, width: 1))),
          child: Obx(() => Column(
                children: controller.applicationController.state
                            .recommendUserList.value.list.length >
                        3
                    ? controller.applicationController.state.recommendUserList
                        .value.list
                        .sublist(0, 3)
                        .map(
                          (item) => getUserList(
                            item.avatar,
                            item.userName,
                            item.nickName,
                            intro: item.intro,
                            avatarPressed: () {
                              Get.toNamed(
                                AppRoutes.personal,
                                arguments: item.userId,
                              );
                            },
                            buttonPressed: () {
                              getSubscribeBox(
                                userId: item.userId,
                                avatar: item.avatar,
                                userName: item.nickName,
                                reSault: () {
                                  controller.handSubscribeinfo(item);
                                },
                              );
                            },
                          ),
                        )
                        .toList()
                    : controller.applicationController.state.recommendUserList
                        .value.list
                        .map(
                          (item) => getUserList(
                            item.avatar,
                            item.userName,
                            item.nickName,
                            intro: item.intro,
                            buttonPressed: () {
                              getSubscribeBox(
                                userId: item.userId,
                                avatar: item.avatar,
                                userName: item.nickName,
                                reSault: () {
                                  controller.handSubscribeinfo(item);
                                },
                              );
                            },
                          ),
                        )
                        .toList(),
              )),
        );

        Widget remmondBox = Obx(() => controller.applicationController.state
                .recommendUserList.value.list.isNotEmpty
            ? Column(
                children: [
                  SizedBox(height: 10.h),
                  getButtonList(title: '推荐订阅', iconRight: const SizedBox()),
                  recommend,
                  getButtonList(
                      title: '查看更多', onPressed: controller.handleRemmondMore),
                ],
              )
            : const SizedBox());

        Widget fixedBox = Column(
          children: [
            SizedBox(
              height: 16.h,
            ),
            swiper,
            SizedBox(
              height: 16.h,
            ),
            getButtonList(title: '热门分类', iconRight: const SizedBox()),
            Container(
              width: double.infinity,
              height: 1.h,
              color: AppColors.line,
            ),
            warp,
            Container(
              width: double.infinity,
              height: 1.h,
              color: AppColors.line,
            ),
            getButtonList(
                title: '查看更多', onPressed: controller.handleRemmondMore),
            SizedBox(height: 16.h),
            getButtonList(title: '精彩活动', iconRight: const SizedBox()),
            activity,
            remmondBox,
            SizedBox(height: 16.h),
          ],
        );

        Widget noData = getRefresher(
          controller: controller.refreshController,
          child: ListView(
            children: [
              fixedBox,
              noDataList,
            ],
          ),
          onRefresh: controller.onRefresh,
          isFooter: false,
        );

        // 整体布局
        Widget _body = Obx(
          () => controller.applicationController.state.contentListHome.value
                  .list.isEmpty
              ? noData
              : getRefresher(
                  controller: controller.refreshController,
                  child: ListView(
                    children: [
                      fixedBox,
                      for (int index = 0;
                          index <
                              controller.applicationController.state
                                  .contentListHome.value.list.length;
                          index++)
                        getContentListView(
                          controller
                              .applicationController.state.contentListHome,
                          index,
                        ),
                    ],
                  ),
                  onLoading: controller.onLoading,
                  onRefresh: controller.onRefresh,
                ),
        );

        /// body
        Widget body = Obx(
          () => controller.applicationController.state.isLoadingHome
              ? loading
              : _body,
        );

        /// 页面
        return Scaffold(
          backgroundColor: AppColors.mainBacground,
          appBar: appBar,
          body: body,
        );
      },
    );
  }
}
