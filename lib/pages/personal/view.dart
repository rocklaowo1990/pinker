import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/personal/library.dart';

import 'package:pinker/values/colors.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PersonalView extends StatelessWidget {
  const PersonalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return GetBuilder<PersonalController>(
      init: PersonalController(),
      builder: (controller) {
        /// 这个appbar是自定义的，嵌套了内置的bar
        ///
        /// 主要用途是现实和隐藏背景
        ///
        /// 往上拖的时候，到达一定位置会显示头像，以及带背景的appbar
        Widget appBar = SizedBox(
          height: 44.h,
          child: getAppBar(
            const SizedBox(),
            backgroundColor: Colors.transparent,
            leading: Center(
              child: getButton(
                height: 16.w,
                width: 16.w,
                background: AppColors.mainBacground50,
                child: SvgPicture.asset(
                  'assets/svg/icon_back.svg',
                  height: 8.w,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ),
        );

        /// 头像漂浮
        Widget avatar = Positioned(
          top: 60.h,
          left: 9.w,
          child: Obx(
            () => controller.state.intro.value.avatar.isNotEmpty
                ? getNetworkImageBox(
                    controller.state.intro.value.avatar,
                    width: 40.w,
                    height: 40.w,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.secondBacground,
                      width: 3.w,
                    ),
                  )
                : Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.line,
                    ),
                  ),
          ),
        );

        /// banner 区域
        Widget banner = Stack(
          clipBehavior: Clip.none,
          children: [
            Obx(
              () => controller.state.intro.value.bannerPic.isEmpty
                  ? Image.asset(
                      'assets/images/personal_banner.png',
                      height: 80.h,
                    )
                  : getNetworkImageBox(
                      controller.state.intro.value.bannerPic,
                      width: double.infinity,
                      height: 80.h,
                      border: Border.all(
                        color: AppColors.mainBacground,
                        width: 2.w,
                      ),
                    ),
            ),
            avatar,
          ],
        );

        Widget nameBox = Padding(
          padding: EdgeInsets.fromLTRB(9.w, 4.h, 9.w, 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  Obx(
                    () => getSpan(
                      controller.state.intro.value.nickName,
                      fontSize: 20,
                    ),
                  ),
                  Obx(
                    () => getSpan(
                      '@${controller.state.intro.value.userName}',
                      color: AppColors.secondText,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  getButton(child: getSpan('打赏')),
                  SizedBox(width: 3.w),
                  getButton(child: getSpan('私信')),
                  SizedBox(width: 3.w),
                  getButton(child: getSpan('订阅')),
                ],
              )
            ],
          ),
        );

        Widget intro = Padding(
          padding: EdgeInsets.fromLTRB(9.w, 0, 9.w, 8.h),
          child: Obx(
            () => getSpan(
              controller.state.intro.value.intro.isEmpty
                  ? '个人简介：这个家伙很懒，什么也没留下～'
                  : '个人简介：${controller.state.intro.value.intro}',
              color: AppColors.secondText,
            ),
          ),
        );

        Widget date = Padding(
          padding: EdgeInsets.fromLTRB(9.w, 0, 9.w, 0),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/svg/icon_date.svg',
                height: 15,
              ),
              SizedBox(width: 4.w),
              Obx(
                () => getSpan(
                  '${DateTime.fromMillisecondsSinceEpoch(controller.state.intro.value.createDate).year} 年 ${DateTime.fromMillisecondsSinceEpoch(controller.state.intro.value.createDate).month} 月 ${DateTime.fromMillisecondsSinceEpoch(controller.state.intro.value.createDate).day} 日加入',
                  color: AppColors.secondText,
                ),
              ),
            ],
          ),
        );

        Widget count = Padding(
          padding: EdgeInsets.fromLTRB(9.w, 0, 9.w, 0),
          child: Row(
            children: [
              getButton(
                background: Colors.transparent,
                overlayColor: Colors.transparent,
                padding: EdgeInsets.fromLTRB(0, 0, 9.w, 0),
                child: Row(
                  children: [
                    Obx(
                      () =>
                          getSpan('${controller.state.intro.value.fansCount}'),
                    ),
                    getSpan(' 粉丝', color: AppColors.secondText),
                  ],
                ),
              ),
              SizedBox(width: 4.w),
              getButton(
                background: Colors.transparent,
                overlayColor: Colors.transparent,
                padding: EdgeInsets.fromLTRB(0, 0, 9.w, 0),
                child: Row(
                  children: [
                    Obx(
                      () => getSpan(
                          '${controller.state.intro.value.followCount}'),
                    ),
                    getSpan(' 正在订阅', color: AppColors.secondText),
                  ],
                ),
              ),
            ],
          ),
        );

        Widget _tabBar(String title, int index) {
          return Obx(() => getSpan(
                title,
                fontSize: 17,
                color: controller.state.pageIndex == index
                    ? AppColors.mainColor
                    : AppColors.secondIcon,
                fontWeight: controller.state.pageIndex == index
                    ? FontWeight.w600
                    : null,
              ));
        }

        Widget tabBar = Container(
          width: 33.w,
          height: 56,
          decoration: BoxDecoration(
            border: Border(
              // top: BorderSide(width: 0.5.w, color: AppColors.line),
              bottom: BorderSide(width: 0.5.w, color: AppColors.line),
            ),
          ),
          child: TabBar(
            labelPadding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.zero,
            indicatorWeight: 1.w,

            tabs: [
              _tabBar('作品', 0),
              _tabBar('限免', 1),
              _tabBar('回复', 2),
              _tabBar('转发', 3),
              _tabBar('喜欢', 4),
            ],
            // onTap: controller.handleChangedTab,
            controller: controller.tabController,
            labelColor: Colors.transparent,
            // indicatorColor: Colors.transparent,
            unselectedLabelColor: Colors.transparent,
            automaticIndicatorColorAdjustment: false,
          ),
        );

        Widget pageView = SizedBox(
          width: double.infinity,
          height: Get.height - 44.h - 33.w,
          child: PageView(
            controller: controller.pageController,
            children: <Widget>[
              Container(
                height: 5000,
                width: double.infinity,
                color: AppColors.mainColor,
              ),
              Container(
                height: 5000,
                width: double.infinity,
                color: AppColors.mainColor,
              ),
              Container(
                height: 5000,
                width: double.infinity,
                color: AppColors.mainColor,
              ),
              Container(
                height: 5000,
                width: double.infinity,
                color: AppColors.mainColor,
              ),
              Container(
                height: 5000,
                width: double.infinity,
                color: AppColors.mainColor,
              ),
            ],
            onPageChanged: controller.handlePageChanged,
          ),
        );

        /// 主体组成
        Widget body = getRefresher(
          controller: controller.refreshController,
          child: ListView(
            children: [banner, nameBox, intro, date, count, tabBar, pageView],
          ),
          onLoading: controller.onLoading,
          onRefresh: controller.onRefresh,
          header: const WaterDropMaterialHeader(
            backgroundColor: AppColors.mainColor,
          ),
        );

        /// 页面
        return Scaffold(
          backgroundColor: AppColors.secondBacground,
          body: Stack(
            children: [
              body,
              appBar,
            ],
          ),
        );
      },
    );
  }
}
