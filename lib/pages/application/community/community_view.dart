import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/application/community/library.dart';

import 'package:pinker/routes/app_pages.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class CommunityView extends GetView<CommunityController> {
  const CommunityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _leftChild(String title, int index) {
      return Obx(
        () => GestureDetector(
          onTap: () {
            controller.handleChangedTab(index);
          },
          child: Container(
            child: getSpan(
              title,
              fontSize: 17,
              color: controller.state.pageIndex == index
                  ? AppColors.mainColor
                  : AppColors.secondIcon,
              fontWeight:
                  controller.state.pageIndex == index ? FontWeight.w600 : null,
            ),
            padding: const EdgeInsets.only(bottom: 14, top: 14),
            decoration: BoxDecoration(
              border: controller.state.pageIndex == index
                  ? Border(
                      bottom:
                          BorderSide(width: 1.6.w, color: AppColors.mainColor),
                    )
                  : null,
            ),
          ),
        ),
      );
    }

    Widget left = Row(
      children: [
        _leftChild('最新', 0),
        SizedBox(width: 16.w),
        _leftChild('最热', 1),
      ],
    );

    Widget right = getButton(
      child: SvgPicture.asset(
        'assets/svg/icon_search_1.svg',
      ),
      background: Colors.transparent,
      width: 33.h,
      height: 33.h,
      onPressed: () {},
    );

    /// AppBar
    AppBar appBar = getMainBar(
      left: left,
      right: right,
    );

    // /// body
    // Widget body = PageView(
    //   controller: controller.pageController,
    //   children: const [
    //     ContentListNewView(),
    //     ContentListHotView(),
    //   ],
    //   onPageChanged: controller.handlePageChanged,
    // );

    // Widget body = ExtendedImageGesturePageView.builder(
    //   itemBuilder: (BuildContext context, int _index) {
    //     if (_index == 0) {
    //       return const ContentListNewView();
    //     } else {
    //       return const ContentListHotView();
    //     }
    //   },
    //   itemCount: 2,
    //   controller: controller.pageController,
    //   onPageChanged: controller.handleChangedTab,
    // );

    /// body
    Widget body = Navigator(
      key: Get.nestedKey(3),
      initialRoute: AppRoutes.contentNew,
      onGenerateRoute: controller.onGenerateRoute,
    );

    /// 页面
    return Scaffold(
      backgroundColor: AppColors.mainBacground,
      appBar: appBar,
      body: body,
    );
  }
}
