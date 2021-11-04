import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:pinker/pages/application/community/library.dart';
import 'package:pinker/pages/application/community/widgets/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 控制器
    final CommunityController controller = CommunityController();

    ///
    Widget _leftChild(String title, int index) {
      return Obx(
        () => GestureDetector(
          onTap: () {
            controller.handleChangedTab(index);
          },
          child: Container(
            child: getSpan(
              title,
              fontSize: 9.5.sp,
              color: controller.state.pageIndex == index
                  ? AppColors.mainColor
                  : AppColors.secondIcon,
              fontWeight:
                  controller.state.pageIndex == index ? FontWeight.w600 : null,
            ),
            padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
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

    /// body
    Widget body = PageView(
      controller: controller.pageController,
      children: const [
        NewView(),
        HotView(),
      ],
      onPageChanged: controller.handlePageChanged,
    );

    /// 页面
    return Scaffold(
      backgroundColor: AppColors.mainBacground,
      appBar: appBar,
      body: body,
    );
  }
}
