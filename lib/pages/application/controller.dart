import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';
import 'package:pinker/pages/application/library.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class ApplicationController extends GetxController {
  final ApplicationState state = ApplicationState();
  final PageController pageController = PageController();

  @override
  void onInit() {
    interval(
      state.rxInt,
      (int value) {
        state.pageIndex = value;
        pageController.jumpToPage(state.pageIndex);
      },
      time: const Duration(milliseconds: 200),
    );
    super.onInit();
  }

  /// 底部导航子组件
  Widget bottomChild(int index) {
    Widget child = const Icon(Icons.home);
    switch (index) {
      case 0:
        child = Obx(
          () => Icon(
            Icons.home,
            color: state.pageIndex == index
                ? AppColors.mainColor
                : AppColors.secondIcon,
          ),
        );
        break;
      case 1:
        child = Obx(
          () => Icon(
            Icons.public,
            color: state.pageIndex == index
                ? AppColors.mainColor
                : AppColors.secondIcon,
          ),
        );
        break;
      case 2:
        child = Obx(
          () => Icon(
            Icons.sms,
            color: state.pageIndex == index
                ? AppColors.mainColor
                : AppColors.secondIcon,
          ),
        );
        break;
      case 3:
        child = Obx(
          () => Icon(
            Icons.person,
            color: state.pageIndex == index
                ? AppColors.mainColor
                : AppColors.secondIcon,
          ),
        );
        break;

      default:
    }
    return getButton(
      child: child,
      width: 32.h,
      height: 32.h,
      background: Colors.transparent,
      onPressed: () {
        if (state.rxIntValue != index) state.rxIntValue = index;
      },
    );
  }

  /// 页面销毁
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
