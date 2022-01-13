import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:pinker/pages/application/community/free/library.dart';
import 'package:pinker/pages/application/community/hot/library.dart';

import 'package:pinker/pages/application/community/library.dart';
import 'package:pinker/pages/application/community/new/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommunityController>(
        init: CommunityController(),
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
            width: 99.w,
            child: TabBar(
              indicatorPadding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              indicatorWeight: 1.w,
              // isScrollable: true,
              tabs: [
                _leftChild('限免', 0),
                _leftChild('最新', 1),
                _leftChild('最热', 2),
              ],
              overlayColor:
                  MaterialStateProperty.all(Colors.transparent), //点击的时候原点的颜色
              labelColor: Colors.transparent,
              // indicatorColor: Colors.transparent,
              unselectedLabelColor: Colors.transparent,
              automaticIndicatorColorAdjustment: false,

              onTap: controller.handleChangedTab,
              controller: controller.tabController,
            ),
          );

          Widget right = getButton(
            child: SvgPicture.asset(
              'assets/svg/icon_search_1.svg',
            ),
            background: Colors.transparent,
            width: 33.h,
            height: 33.h,
            onPressed: controller.handleSearch,
          );

          /// AppBar
          AppBar appBar = getMainBar(
            left: left,
            right: right,
          );

          /// body
          Widget body = PageView(
            controller: controller.pageController,
            children: const [
              ContentListFreeView(),
              ContentListNewView(),
              ContentListHotView(),
            ],
            onPageChanged: controller.handlePageChanged,
          );

          /// 页面
          return Scaffold(
            backgroundColor: AppColors.mainBacground,
            appBar: appBar,
            body: body,
          );
        });
  }
}
