import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/entities/personal.dart';
import 'package:pinker/pages/personal/all/view.dart';
import 'package:pinker/pages/personal/forward/view.dart';
import 'package:pinker/pages/personal/free/library.dart';

import 'package:pinker/pages/personal/library.dart';
import 'package:pinker/pages/personal/like/view.dart';
import 'package:pinker/pages/personal/reply/view.dart';

import 'package:pinker/values/colors.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class PersonalView extends StatelessWidget {
  const PersonalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalController>(
      init: PersonalController(),
      builder: (controller) {
        /// 这个appbar是自定义的，嵌套了内置的bar
        ///
        /// 主要用途是现实和隐藏背景
        ///
        /// 往上拖的时候，到达一定位置会显示头像，以及带背景的appbar
        Widget appBar = SizedBox(
          height: 80.h,
          child: Obx(
            () => getAppBar(
              controller.state.opacity == 1
                  ? getSpan(controller.state.intro.value.nickName)
                  : const SizedBox(),
              backgroundColor: Colors.transparent,
              flexibleSpace: controller.state.opacity == 1
                  ? controller.state.intro.value.bannerPic.isNotEmpty
                      ? getNetworkImageBox(
                          controller.state.intro.value.bannerPic,
                          width: Get.width,
                          height: 44.h,
                        )
                      : Image.asset(
                          'assets/images/personal_banner.png',
                          fit: BoxFit.cover,
                          width: Get.width,
                          height: 44.h,
                        )
                  : null,
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
            ),
          ),
        );

        /// 头像漂浮
        Widget avatar = Positioned(
          top: 90.h,
          left: 16.w,
          child: Obx(
            () => controller.state.intro.value.avatar.isNotEmpty
                ? getNetworkImageBox(
                    controller.state.intro.value.avatar,
                    width: 60.w,
                    height: 60.w,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.secondBacground,
                      width: 3.w,
                    ),
                  )
                : Container(
                    width: 60.w,
                    height: 60.w,
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
                      height: 120.h,
                      width: Get.width,
                      fit: BoxFit.cover,
                    )
                  : getNetworkImageBox(
                      controller.state.intro.value.bannerPic,
                      width: Get.width,
                      height: 120.h,
                    ),
            ),
            avatar,
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
                    ? () {
                        getSubscribeBox(
                          userId: controller.state.intro.value.userId,
                          avatar: controller.state.intro.value.avatar,
                          userName: controller.state.intro.value.userName,
                          reSault: () async {
                            ResponseEntity responseEntity = await UserApi.home(
                                userId: controller.arguments);
                            if (responseEntity.code == 200) {
                              controller.state.intro.value =
                                  PersonalEntities.fromJson(
                                      responseEntity.data);
                            } else {
                              getSnackTop(responseEntity.msg);
                            }

                            Future<void> _getPersonalContent(
                                int type, Rx<ContentListEntities> rx) async {
                              ResponseEntity responseEntity =
                                  await ContentApi.userHomeContentList(
                                pageNo: 1,
                                type: type,
                                userId: controller.arguments,
                              );

                              if (responseEntity.code == 200) {
                                rx.value = ContentListEntities.fromJson(
                                    responseEntity.data);
                                rx.update((val) {});
                              } else {
                                getSnackTop(responseEntity.msg);
                              }
                            }

                            await _getPersonalContent(
                                1, controller.state.personalAll);
                            await _getPersonalContent(
                                2, controller.state.personalFree);
                            await _getPersonalContent(
                                3, controller.state.personalReply);
                            await _getPersonalContent(
                                4, controller.state.personalForward);
                            await _getPersonalContent(
                                5, controller.state.personalLike);
                          },
                        );
                      }
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
              Obx(
                () => controller.state.intro.value.userId ==
                        controller
                            .applicationController.state.userInfo.value.userId
                    ? myButton
                    : otherButton,
              ),
            ],
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
                padding: EdgeInsets.fromLTRB(0, 0, 16.w, 0),
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
            border: Border(
              top: BorderSide(
                width: 1.w,
                color: AppColors.line,
              ),
              bottom: BorderSide(
                width: 1.w,
                color: AppColors.line,
              ),
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

          // physics: const NeverScrollableScrollPhysics(),
          onPageChanged: controller.handlePageChanged,
          allowImplicitScrolling: true,
          controller: controller.pageController,

          // itemBuilder: (context, index) {
          //   late final Rx<ContentListEntities> contentList;

          //   switch (index) {
          //     case 0:
          //       contentList = controller.state.personalAll;
          //       break;
          //     case 1:
          //       contentList = controller.state.personalFree;
          //       break;
          //     case 2:
          //       contentList = controller.state.personalReply;
          //       break;
          //     case 3:
          //       contentList = controller.state.personalForward;
          //       break;
          //     default:
          //       contentList = controller.state.personalLike;
          //       break;
          //   }

          //   return MediaQuery.removePadding(
          //     removeTop: true,
          //     context: context,
          //     child: Obx(
          //       () => controller.state.isLoading
          //           ? loading
          //           : contentList.value.list.isEmpty
          //               ? noData
          //               : getRefresher(
          //                   controller: controller.refreshController,
          //                   child: ListView(
          //                     children: contentList.value.list
          //                         .asMap()
          //                         .keys
          //                         .map(
          //                           (e) => getContentListView(
          //                             contentList,
          //                             e,
          //                           ),
          //                         )
          //                         .toList(),
          //                   ),
          //                   onLoading: () {
          //                     controller.onLoading();
          //                   },
          //                   isFooter: contentList.value.list.length < 20
          //                       ? false
          //                       : true,
          //                   onRefresh: () {
          //                     controller.onRefresh();
          //                   },
          //                 ),
          //     ),
          //   );
          // },
          // itemCount: 5,
          // controller: controller.pageController,
          // allowImplicitScrolling: true,
          // onPageChanged: controller.handlePageChanged,
        );

        /// 主体组成
        // Widget body = getRefresher(
        //   controller: controller.refreshController,
        //   scrollController: controller.scrollController,
        //   child: CustomScrollView(
        //     controller: controller.scrollController,
        //     slivers: [
        //       SliverList(
        //         delegate: SliverChildListDelegate(
        //           [
        //             banner,
        //             nameBox,
        //             intro,
        //             date,
        //             count,
        //             tabBar,
        //           ],
        //         ),
        //       ),
        //       SliverFillViewport(
        //         delegate: SliverChildBuilderDelegate(
        //           (context, index) {
        //             return pageView;
        //           },
        //           childCount: 1,
        //         ),
        //       )
        //     ],
        //   ),
        //   onLoading: controller.onLoading,
        //   onRefresh: controller.onRefresh,
        //   header: const WaterDropMaterialHeader(
        //     backgroundColor: AppColors.mainColor,
        //   ),
        //   isFooter: false,
        // );
        Widget body = NestedScrollView(
          controller: controller.scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    banner,
                    nameBox,
                    intro,
                    date,
                    count,
                    SizedBox(height: 16.w),
                    tabBar,
                  ],
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
