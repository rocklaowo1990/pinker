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
        // var list = ['首页'];
        // Widget left = getTabBar(
        //   list,
        //   controller.state.pageIndexRx,
        //   controller: controller.tabController,
        // );

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

        //AppBar
        // AppBar appBar = getMainBar(
        //   left: left,
        //   right: const SizedBox(),
        // );

        /// appBar
        AppBar appBar = getAppBar(
          getLogoIcon(),
          leading: Obx(
            () => controller
                    .applicationController.state.userInfo.value.avatar.isEmpty
                ? const SizedBox()
                : getButtonTransparent(
                    onPressed: controller.handlePersonal,
                    child: Center(
                      child: getNetworkImageBox(
                        controller
                            .applicationController.state.userInfo.value.avatar,
                        shape: BoxShape.circle,
                        width: 26.w,
                        height: 26.w,
                      ),
                    ),
                  ),
          ),
          backgroundColor: AppColors.secondBacground,
          lineColor: AppColors.line,
        );

        // loading时显示转圈圈
        // Widget loading = getLoadingIcon();

        Widget swiper = Obx(() => controller.applicationController.state
                .homeSwiperKing.value.carousel.isNotEmpty
            ? SizedBox(
                height: 160.h,
                width: double.infinity,
                // color: AppColors.secondBacground,
                child: Obx(
                  () => Swiper(
                    itemBuilder: (BuildContext context, int _index) {
                      return getNetworkImageBox(
                        controller.applicationController.state.homeSwiperKing
                            .value.carousel[_index].pic,
                      );
                    },
                    itemCount: controller.applicationController.state
                        .homeSwiperKing.value.carousel.length,
                    viewportFraction: 1,
                    scale: 1,
                    autoplay: true,
                    autoplayDelay: 3000,
                    pagination: const SwiperPagination(
                      builder: SwiperPagination.dots,
                    ),
                  ),
                ),
              )
            : const SizedBox());

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
                    Radius.circular(16.w),
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
          () => controller.applicationController.state.homeActivity.value.list
                  .isNotEmpty
              ? Column(
                  children: controller
                      .applicationController.state.homeActivity.value.list
                      .map(
                        (e) => _activity(
                          name: e.name,
                          avatar: e.avatar,
                          endDate: e.endDate,
                          joinCount: e.joinCount,
                        ),
                      )
                      .toList(),
                )
              : const SizedBox(),
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
                  SizedBox(height: 16.h),
                  getButtonList(title: '推荐订阅', iconRight: const SizedBox()),
                  recommend,
                  getButtonList(
                      title: '查看更多', onPressed: controller.handleRemmondMore),
                ],
              )
            : const SizedBox());

        // var _body = NestedScrollView(
        //   controller: controller.scrollController,
        //   // floatHeaderSlivers: true,
        //   headerSliverBuilder: (context, innerBoxIsScrolled) {
        //     return [
        //       SliverList(
        //         delegate: SliverChildListDelegate(
        //           [
        //             swiper,
        //             // getButtonList(title: '热门分类', iconRight: const SizedBox()),
        //             Container(
        //               width: double.infinity,
        //               height: 1.h,
        //               color: AppColors.line,
        //             ),
        //             warp,
        //             // Container(
        //             //   width: double.infinity,
        //             //   height: 1.h,
        //             //   color: AppColors.line,
        //             // ),
        //             // getButtonList(
        //             //     title: '查看更多热门分类',
        //             //     onPressed: controller.handleRemmondMore),
        //             SizedBox(height: 16.h),
        //             getButtonList(title: '精彩活动', iconRight: const SizedBox()),
        //             activity,
        //             remmondBox,
        //             SizedBox(height: 16.h),
        //           ],
        //         ),
        //       ),
        //     ];
        //   },
        //   body: Obx(
        //     () => controller.applicationController.state.contentListHome.value
        //             .list.isNotEmpty
        //         ? const SizedBox()
        //         : noDataList,
        //   ),
        // );

        // body
        Widget body = SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            children: [
              swiper,
              // getButtonList(title: '热门分类', iconRight: const SizedBox()),
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
                  title: '查看更多热门分类', onPressed: controller.handleRemmondMore),
              SizedBox(height: 16.h),
              getButtonList(title: '精彩活动', iconRight: const SizedBox()),
              activity,
              remmondBox,
            ],
          ),
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
