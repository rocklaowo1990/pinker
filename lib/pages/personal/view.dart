import 'dart:math';

import 'package:flutter/material.dart';

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
        top: 70,
        left: 16,
        child: SafeArea(
          child: Obx(
            () => controller.state.intro.value.avatar.isNotEmpty
                ? getNetworkImageBox(
                    controller.state.intro.value.avatar,
                    width: 70 * ((100 - controller.state.offsetWidth) / 100),
                    height: 70 * ((100 - controller.state.offsetWidth) / 100),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.secondBacground,
                      width: 3,
                    ),
                  )
                : Container(
                    width: 70 * ((100 - controller.state.offsetWidth) / 100),
                    height: 70 * ((100 - controller.state.offsetWidth) / 100),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.line,
                      border: Border.all(
                        color: AppColors.secondBacground,
                        width: 3,
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/svg/avatar_default.svg',
                      width: 40,
                      height: 40,
                    ),
                  ),
          ),
        ));

    /// banner 区域
    Widget banner = Stack(
      clipBehavior: Clip.none,
      children: [
        Obx(
          () => controller.state.intro.value.bannerPic.isEmpty
              ? Image.asset(
                  'assets/images/personal_banner.png',
                  height: 150,
                  width: Get.width,
                  fit: BoxFit.cover,
                )
              : getNetworkImageBox(
                  controller.state.intro.value.bannerPic,
                  width: Get.width,
                  height: 150,
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
        const SizedBox(width: 8),
        getButtonSheet(
          child: getSpan('私信'),
        ),
        const SizedBox(width: 8),
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
        const SizedBox(width: 8),
        getButtonSheet(
          child: getSpan('个人资料'),
        ),
      ],
    );

    Widget nameBox = Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
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
      expandedHeight: 110,
      title: Obx(() => controller.state.opacity == 1
          ? getSpan(controller.state.intro.value.nickName)
          : const SizedBox()),
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: banner,
      leading: Center(
        child: getButton(
          height: 32,
          width: 32,
          background: AppColors.mainBacground50,
          child: SvgPicture.asset(
            'assets/svg/icon_back.svg',
            height: 16,
            width: 16,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
    );

    Widget intro = Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/svg/icon_date.svg',
            height: 15,
          ),
          const SizedBox(width: 4),
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
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Row(
        children: [
          getButton(
            background: Colors.transparent,
            overlayColor: Colors.transparent,
            padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
            child: Row(
              children: [
                Obx(
                  () => getSpan('${controller.state.intro.value.fansCount}'),
                ),
                getSpan('   粉丝', color: AppColors.secondText),
              ],
            ),
          ),
          const SizedBox(width: 16),
          getButton(
            background: Colors.transparent,
            overlayColor: Colors.transparent,
            padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
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

    Widget tabBar = Container(
      child: getTabBar(
        controller.list,
        controller.state.pageIndexRx,
        controller: controller.tabController,
        onTap: controller.handleChangedTab,
      ),
      width: double.infinity,
      height: 55,
      decoration: const BoxDecoration(
        color: AppColors.secondBacground,
        border: Border(
          top: BorderSide(width: 1, color: AppColors.line),
          bottom: BorderSide(width: 1, color: AppColors.line),
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
                const SizedBox(height: 16),
              ],
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            // floating: true,
            delegate: _SliverAppBarDelegate(
              child: tabBar,
              maxHeight: 55,
              minHeight: 55,
            ),
          ),
        ];
      },
      body: Container(
        child: pageView,
        color: AppColors.mainBacground,
      ),
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
