import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/personal/all/view.dart';
import 'package:pinker/pages/personal/forward/view.dart';
import 'package:pinker/pages/personal/free/library.dart';

import 'package:pinker/pages/personal/library.dart';
import 'package:pinker/pages/personal/like/view.dart';
import 'package:pinker/pages/personal/reply/view.dart';

import 'package:pinker/values/colors.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class PersonalView extends GetView<PersonalController> {
  const PersonalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 头像漂浮
    Widget avatar = Positioned(
      top: 120.h,
      left: 16.w,
      child: Obx(
        () => controller.state.intro.value.avatar.isNotEmpty
            ? getNetworkImageBox(
                controller.state.intro.value.avatar,
                width: 70.w * ((100 - controller.state.offsetWidth) / 100),
                height: 70.w * ((100 - controller.state.offsetWidth) / 100),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.secondBacground,
                  width: 3.w,
                ),
              )
            : Container(
                width: 70.w * ((100 - controller.state.offsetWidth) / 100),
                height: 70.w * ((100 - controller.state.offsetWidth) / 100),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.line,
                  border: Border.all(
                    color: AppColors.secondBacground,
                    width: 3.w,
                  ),
                ),
                child: SvgPicture.asset(
                  'assets/svg/avatar_default.svg',
                  width: 40.w,
                  height: 40.w,
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
                  height: 150.h,
                  width: Get.width,
                  fit: BoxFit.cover,
                )
              : getNetworkImageBox(
                  controller.state.intro.value.bannerPic,
                  width: Get.width,
                  height: 150.h,
                ),
        ),
        Obx(() => controller.state.opacity == 0 ? avatar : const SizedBox()),
      ],
    );

    Widget otherButton = Row(
      children: [
        getButtonSheet(
          child: getSpan('打赏'),
        ),
        SizedBox(width: 8.w),
        getButtonSheet(
          child: getSpan('私信'),
        ),
        SizedBox(width: 8.w),
        Obx(
          () => getButtonSheet(
            child: getSpan(
              controller.state.intro.value.isSubscribe == 0 ? '订阅' : '已订阅',
            ),
            onPressed: controller.state.intro.value.isSubscribe == 0
                ? controller.handleSub
                : null,
          ),
        ),
      ],
    );

    Widget myButton = Row(
      children: [
        getButtonSheet(
          child: getSpan('打赏列表'),
        ),
        SizedBox(width: 8.w),
        getButtonSheet(
          child: getSpan('个人资料'),
        ),
      ],
    );

    Widget nameBox = Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
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
          ),
          Obx(
            () => controller.state.intro.value.userId ==
                    controller.applicationController.state.userInfo.value.userId
                ? myButton
                : otherButton,
          ),
        ],
      ),
    );

    var appBar = SliverAppBar(
      pinned: true,
      expandedHeight: 110.h,
      title: Obx(() => controller.state.opacity == 1
          ? getSpan(controller.state.intro.value.nickName)
          : const SizedBox()),
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: banner,
      leading: Center(
        child: getButton(
          height: 32.w,
          width: 32.w,
          background: AppColors.mainBacground50,
          child: SvgPicture.asset(
            'assets/svg/icon_back.svg',
            height: 16.w,
            width: 16.w,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
    );

    Widget intro = Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      child: Obx(
        () => SizedBox(
          width: double.infinity,
          child: getSpan(
            controller.state.intro.value.intro.isEmpty
                ? '个人简介：这个家伙很懒，什么也没留下～'
                : '个人简介：${controller.state.intro.value.intro}',
            color: AppColors.secondText,
          ),
        ),
      ),
    );

    Widget date = Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/svg/icon_date.svg',
            height: 15.sp,
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
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
      child: Row(
        children: [
          getButton(
            background: Colors.transparent,
            overlayColor: Colors.transparent,
            padding: EdgeInsets.fromLTRB(0, 0, 16.w, 0),
            child: Row(
              children: [
                Obx(
                  () => getSpan('${controller.state.intro.value.fansCount}'),
                ),
                getSpan('   粉丝', color: AppColors.secondText),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          getButton(
            background: Colors.transparent,
            overlayColor: Colors.transparent,
            padding: EdgeInsets.fromLTRB(0, 0, 16.w, 0),
            child: Row(
              children: [
                Obx(
                  () => getSpan('${controller.state.intro.value.followCount}'),
                ),
                getSpan('   正在订阅', color: AppColors.secondText),
              ],
            ),
          ),
        ],
      ),
    );

    var list = ['作品', '限免', '回复', '转发', '喜欢'];
    Widget tabBar = Container(
      child: getTabBar(
        list,
        controller.state.pageIndexRx,
        controller: controller.tabController,
        onTap: controller.handleChangedTab,
      ),
      width: double.infinity,
      height: 55.h,
      decoration: BoxDecoration(
        color: AppColors.secondBacground,
        border: Border(
          top: BorderSide(width: 1.w, color: AppColors.line),
          bottom: BorderSide(width: 1.w, color: AppColors.line),
        ),
      ),
    );

    Widget pageView = PageView(
      children: [
        personalAllView(),
        personalFreeView(),
        personalReplyView(),
        personalForwardView(),
        personalLikeView(),
      ],
      onPageChanged: controller.handlePageChanged,
      allowImplicitScrolling: true,
      controller: controller.pageController,
    );

    Widget body = NestedScrollView(
      controller: controller.scrollController,
      headerSliverBuilder: (context, inner) {
        return [
          appBar,
          SliverToBoxAdapter(
            child: Column(
              children: [
                nameBox,
                intro,
                date,
                count,
                SizedBox(height: 16.w),
              ],
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            // floating: true,
            delegate: _SliverAppBarDelegate(
              child: tabBar,
              maxHeight: 55.h,
              minHeight: 55.h,
            ),
          ),
        ];
      },
      body: pageView,
    );

    /// 页面
    return Material(
      color: AppColors.secondBacground,
      child: body,
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
