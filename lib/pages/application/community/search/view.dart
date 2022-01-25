import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/application/community/search/library.dart';
import 'package:pinker/pages/application/community/search/new/library.dart';
import 'package:pinker/pages/application/community/search/photo/library.dart';
import 'package:pinker/pages/application/community/search/user/library.dart';
import 'package:pinker/pages/application/community/search/video/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
        init: SearchController(),
        builder: (controller) {
          var list = ['最新', '用户', '照片', '视频'];
          Widget left = getTabBar(
            list,
            controller.state.pageIndexRx,
            controller: controller.tabController,
            onTap: controller.handleChangedTab,
          );

          Widget tabBar = SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: Get.width,
              height: 48,
              color: AppColors.secondBacground,
              child: left,
            ),
          );
          Widget pages = PageView(
            controller: controller.pageController,
            children: const [
              ContentListSearchNewView(),
              // ContentListSearchHotView(),
              ContentListSearchUserView(),
              ContentListSearchPhotoView(),
              ContentListSearchVideoView(),
              // ContentListSearchFreeView(),
            ],
            // physics: const NeverScrollableScrollPhysics(),
            onPageChanged: controller.handlePageChanged,
            allowImplicitScrolling: true,
          );

          Widget searchEndBox = Column(
            children: [
              tabBar,
              Container(
                height: 0.8.w,
                width: double.infinity,
                color: AppColors.line,
              ),
              Expanded(child: pages),
            ],
          );

          Widget body = Obx(
            () => controller.state.isSearchEnd
                ? searchEndBox
                : controller.state.textData.isEmpty &&
                        controller.state.userData.value.list.isEmpty
                    ? Column(
                        children: [
                          SizedBox(height: 20.h),
                          getSpan('您可以在这里找到您要找的用户，推文等信息',
                              color: AppColors.secondText),
                        ],
                      )
                    : MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView(
                          children: [
                            getButtonList(
                                title: '最新搜索记录',
                                iconRight: const Icon(
                                  Icons.close,
                                  color: AppColors.mainIcon,
                                  size: 20,
                                ),
                                onPressed: () {}),
                            Container(
                              width: double.infinity,
                              height: 0.5.w,
                              color: AppColors.line,
                            ),
                            for (int i = 0;
                                i < controller.state.textData.length;
                                i++)
                              Column(
                                children: [
                                  getButtonList(
                                    title: controller.state.textData[i],
                                    onPressed: () {
                                      controller.textController.text =
                                          controller.state.textData[i];

                                      controller.handleSearch();
                                    },
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 0.5.w,
                                    color: AppColors.line,
                                  ),
                                ],
                              )
                          ],
                        ),
                      ),
          );

          Widget scaffold = Column(
            children: [
              Container(
                width: double.infinity,
                height: 80.h,
                padding: EdgeInsets.fromLTRB(0, 40.h, 16.w, 4.h),
                child: Row(
                  children: [
                    getBackButton(),
                    Expanded(
                        child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                        child: getInput(
                          type: '搜索',
                          controller: controller.textController,
                          focusNode: controller.focusNode,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.w, 8.h, 0.w, 8.h),
                        ),
                      ),
                    )),
                    Obx(
                      () => controller.state.isShowSearch &&
                              !controller.state.isSearchEnd
                          ? Row(
                              children: [
                                SizedBox(width: 8.w),
                                getButtonSheet(
                                  child: getSpan('搜索'),
                                  onPressed: controller.handleSearch,
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondBacground,
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5.w,
                      color: AppColors.line,
                    ),
                  ),
                ),
              ),
              Expanded(child: body),
            ],
          );

          return Scaffold(
            body: scaffold,
            backgroundColor: AppColors.mainBacground,
          );
        });
  }
}
