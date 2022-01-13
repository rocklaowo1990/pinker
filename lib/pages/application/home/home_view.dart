import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/application/home/library.dart';

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
        Widget _leftChild(String title, int index) {
          return Obx(() => Container(
                width: 24.w,
                child: Center(
                  child: getSpan(
                    title,
                    fontSize: 17,
                    color: controller.state.pageIndex == index
                        ? AppColors.mainColor
                        : AppColors.secondIcon,
                    fontWeight: controller.state.pageIndex == index
                        ? FontWeight.w600
                        : null,
                  ),
                ),
                padding: const EdgeInsets.only(bottom: 15, top: 15),
              ));
        }

        Widget left = SizedBox(
          width: 33.w,
          child: TabBar(
            labelPadding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.zero,
            indicatorWeight: 1.w,

            tabs: [
              _leftChild('首页', 0),
            ],
            onTap: controller.handleChangedTab,
            controller: controller.tabController,
            labelColor: Colors.transparent,
            // indicatorColor: Colors.transparent,
            unselectedLabelColor: Colors.transparent,
            automaticIndicatorColorAdjustment: false,
          ),
        );

        // appbar 右侧按钮
        Widget right = getButton(
          child: SvgPicture.asset(
            'assets/svg/icon_mail_3.svg',
          ),
          background: Colors.transparent,
          width: 33.h,
          height: 33.h,
          onPressed: controller.handleMail,
        );

        /// AppBar
        AppBar appBar = getMainBar(
          left: left,
          right: right,
        );

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
        Widget noDataList = Container(
          padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 20.w),
          color: AppColors.secondBacground,
          width: double.infinity,
          child: Column(
            children: [
              getSpan('什么？还没有推文？', fontSize: 22),
              SizedBox(height: 10.h),
              getSpan(
                '这条空白的时间线将很快消失，开始关注用户，您再次回到这里将看到他们的推文',
                textAlign: TextAlign.center,
                color: AppColors.secondText,
              ),
              SizedBox(height: 16.h),
              getButton(
                child: getSpan('寻找值得订阅的用户'),
                height: 26.h,
                width: 100.w,
                onPressed: controller.handleRemmondMore,
              )
            ],
          ),
        );

        Widget swiper = SizedBox(
          height: 125.h,
          width: double.infinity,
          child: Swiper(
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
            itemCount: 3,
            viewportFraction: 0.8,
            scale: 0.9,
            pagination: const SwiperPagination(),
          ),
        );

        Widget _warp() {
          return getButton(
            background: Colors.transparent,
            overlayColor: Colors.transparent,
            onPressed: () {},
            width: 187.5.w / 4,
            child: Column(
              children: [
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: AppColors.thirdIcon,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.w),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                getSpan('标题文字'),
              ],
            ),
          );
        }

        Widget _activity() {
          return Container(
            padding: EdgeInsets.fromLTRB(9.w, 9.w, 9.w, 0),
            color: AppColors.secondBacground,
            child: Row(
              children: [
                Container(
                  width: 75.w,
                  height: 55.w,
                  decoration: BoxDecoration(
                    color: AppColors.thirdIcon,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.w),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: getSpan(
                          '这里是文件的表体这里是文件的表体这里是文件的表体这里是文件的表体',
                          fontSize: 17,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 3.w),
                      SizedBox(
                        width: double.infinity,
                        child: getSpan('1777 人参与', color: AppColors.mainColor),
                      ),
                      SizedBox(height: 2.w),
                      SizedBox(
                        width: double.infinity,
                        child: getSpan('活动时间：截止到9月1日',
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

        Widget activity = Column(
          children: [
            _activity(),
            _activity(),
            _activity(),
            Container(
              height: 9.w,
              width: double.infinity,
              color: AppColors.secondBacground,
            ),
          ],
        );

        Widget warp = Container(
          color: AppColors.secondBacground,
          padding: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
          child: Wrap(
            runSpacing: 16.h,
            children: [
              _warp(),
              _warp(),
              _warp(),
              _warp(),
              _warp(),
              _warp(),
              _warp(),
              _warp(),
            ],
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

        Widget noData = getRefresher(
          controller: controller.refreshController,
          child: ListView(
            children: [
              SizedBox(height: 10.h),
              swiper,
              SizedBox(height: 10.h),
              warp,
              SizedBox(height: 10.h),
              activity,
              remmondBox,
              SizedBox(height: 10.h),
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
                      SizedBox(height: 10.h),
                      swiper,
                      SizedBox(height: 10.h),
                      warp,
                      SizedBox(height: 10.h),
                      activity,
                      remmondBox,
                      SizedBox(height: 10.h),
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
        Widget body = Obx(() =>
            controller.applicationController.state.isLoadingHome
                ? loading
                : _body);

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
