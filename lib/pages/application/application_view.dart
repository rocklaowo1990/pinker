import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/application/chat/library.dart';
import 'package:pinker/pages/application/community/library.dart';
import 'package:pinker/pages/application/home/home_view.dart';

import 'package:pinker/pages/application/library.dart';
import 'package:pinker/pages/application/my/my_view.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class ApplicationView extends GetView<ApplicationController> {
  const ApplicationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 底部导航子组件
    Widget _bottomChild(int index) {
      Widget _child(IconData icon) {
        return Obx(
          () => Icon(
            icon,
            color: controller.state.pageIndex == index
                ? AppColors.mainColor
                : AppColors.secondIcon,
          ),
        );
      }

      Widget child = _child(Icons.home);

      switch (index) {
        case 0:
          child = _child(Icons.home);
          break;
        case 1:
          child = _child(Icons.public);

          break;
        case 2:
          child = _child(Icons.sms);

          break;
        case 3:
          child = _child(Icons.person);
          break;

        default:
      }
      return getButton(
        child: child,
        width: 50.h,
        height: 50.h,
        background: Colors.transparent,
        onPressed: () {
          if (controller.state.rxIntValue != index) {
            controller.state.rxIntValue = index;
          }
          controller.pageController.jumpToPage(index);
        },
      );
    }

    /// 底部导航
    Widget bottomNavigationBar = Container(
      width: double.infinity,
      height: 50.h,
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      decoration: BoxDecoration(
        color: AppColors.secondBacground,
        border: Border(
          top: BorderSide(width: 0.5.w, color: AppColors.line),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _bottomChild(0),
          _bottomChild(1),
          _bottomChild(2),
          _bottomChild(3),
        ],
      ),
    );

    /// body
    Widget body = PageView(
      controller: controller.pageController,
      children: const [
        HomeView(),
        CommunityView(),
        ChatView(),
        MyView(),
      ],
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: controller.handlePageChanged,
      allowImplicitScrolling: true,
    );

    // /// body
    // Widget body = Navigator(
    //   key: Get.nestedKey(2),
    //   initialRoute: AppRoutes.home,
    //   onGenerateRoute: controller.onGenerateRoute,
    // );

    Widget floatButton = Obx(() => controller.state.pageIndex == 0
        ? getButton(
            child: const Icon(
              Icons.add,
              color: AppColors.mainIcon,
            ),
            width: 50.w,
            height: 50.w,
            onPressed: () {
              getDialog(
                child: DialogChild.alert(
                  title: '提示',
                  content: '功能制作中...',
                  leftText: '确认',
                  onPressedLeft: () {
                    Get.back();
                  },
                ),
              );
            },
          )
        : const SizedBox());

    /// 页面
    return Scaffold(
      backgroundColor: AppColors.mainBacground,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatButton,
    );
  }
}
