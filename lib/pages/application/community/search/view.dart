import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/application/community/search/library.dart';
import 'package:pinker/pages/application/community/search/new/library.dart';
import 'package:pinker/pages/application/community/search/photo/library.dart';
import 'package:pinker/pages/application/community/search/user/library.dart';
import 'package:pinker/pages/application/community/search/video/library.dart';
import 'package:pinker/values/colors.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
        init: SearchController(),
        builder: (controller) {
          Widget left = getTabBar(
            controller.list,
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
                height: 1.h,
                width: double.infinity,
                color: AppColors.line,
              ),
              Expanded(child: pages),
            ],
          );

          AppBar appBar = getAppBar(
            getSearchInput(
              controller.textController,
              controller.focusNode,
              onSubmitted: controller.handleSearch,
            ),
            // lineColor: AppColors.line,

            backgroundColor: AppColors.secondBacground,
          );

          Widget body = Obx(
            () => controller.state.isSearchEnd
                ? searchEndBox
                : controller.state.textData.isEmpty &&
                        controller.state.userData.value.list.isEmpty
                    ? Column(
                        children: [
                          SizedBox(height: 20.h),
                          Center(
                            child: getSpanSecond(
                              '您可以在这里找到您要找的用户，推文等信息',
                            ),
                          ),
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

                                      controller.handleSearch(
                                          controller.textController.text);
                                    },
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 1.w,
                                    color: AppColors.line,
                                  ),
                                ],
                              )
                          ],
                        ),
                      ),
          );

          return Scaffold(
            appBar: appBar,
            body: body,
            backgroundColor: AppColors.mainBacground,
          );
        });
  }
}
