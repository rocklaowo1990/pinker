import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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
          Widget _leftChild(String title, int index) {
            return Obx(() => getSpan(
                  title,
                  color: controller.state.pageIndex == index
                      ? AppColors.mainColor
                      : AppColors.secondIcon,
                  fontWeight: controller.state.pageIndex == index
                      ? FontWeight.w600
                      : null,
                ));
          }

          Widget tabBar = SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: 198.w,
              height: 48,
              color: AppColors.secondBacground,
              child: TabBar(
                onTap: controller.handleChangedTab,
                controller: controller.tabController,
                tabs: [
                  _leftChild('最新', 0),
                  // _leftChild('最热', 1),
                  _leftChild('用户', 1),
                  _leftChild('照片', 2),
                  _leftChild('视频', 3),
                  // _leftChild('限免', 5),
                ],
              ),
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
                height: 68,
                padding: EdgeInsets.fromLTRB(0, 24, 9.w, 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      height: 40,
                      child: getButton(
                        child: SvgPicture.asset('assets/svg/icon_back.svg'),
                        onPressed: () {
                          Get.back();
                        },
                        background: Colors.transparent,
                      ),
                    ),
                    Expanded(
                      child: getInput(
                        type: '搜索',
                        controller: controller.textController,
                        focusNode: controller.focusNode,
                        height: 40,
                      ),
                    ),
                    Obx(
                      () => controller.state.isShowSearch &&
                              !controller.state.isSearchEnd
                          ? Row(
                              children: [
                                SizedBox(width: 8.w),
                                getButton(
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
