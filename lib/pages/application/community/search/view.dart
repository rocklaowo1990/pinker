import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:pinker/pages/application/community/search/free/library.dart';

import 'package:pinker/pages/application/community/search/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
        init: SearchController(),
        builder: (controller) {
          Widget tabBar = SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: 198.w,
              height: 48,
              color: AppColors.secondBacground,
              child: TabBar(
                controller: controller.tabController,
                tabs: [
                  getSpan('最新', color: AppColors.mainColor),
                  getSpan('最热', color: AppColors.secondText),
                  getSpan('用户', color: AppColors.secondText),
                  getSpan('照片', color: AppColors.secondText),
                  getSpan('视频', color: AppColors.secondText),
                  getSpan('限免', color: AppColors.secondText),
                ],
              ),
            ),
          );
          Widget pages = PageView(
            controller: controller.pageController,
            children: const [
              ContentListSearchFreeView(),
            ],
            physics: const NeverScrollableScrollPhysics(),
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
                    : getSpan('有搜索记录的写在这里', color: AppColors.secondText),
          );

          /// body

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
                      () => controller.state.isShowSearch
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
