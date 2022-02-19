import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/pages/application/chat/library.dart';
import 'package:pinker/pages/application/community/library.dart';

import 'package:pinker/pages/application/home/view.dart';

import 'package:pinker/pages/application/library.dart';
import 'package:pinker/pages/application/my/view.dart';
import 'package:pinker/utils/utils.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class ApplicationView extends GetView<ApplicationController> {
  const ApplicationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenInit(context);

    const bottomNavItems = [
      BottomNavigationBarItem(
        backgroundColor: AppColors.secondBacground,
        icon: Icon(Icons.home),
        label: "首页",
      ),
      BottomNavigationBarItem(
        backgroundColor: AppColors.secondBacground,
        icon: Icon(Icons.public),
        label: "社区",
      ),
      BottomNavigationBarItem(
        backgroundColor: AppColors.secondBacground,
        icon: Icon(Icons.message),
        label: "聊天",
      ),
      BottomNavigationBarItem(
        backgroundColor: AppColors.secondBacground,
        icon: Icon(Icons.person),
        label: "我的",
      ),
    ];

    /// 底部导航
    Widget bottomNavigationBar = Obx(
      () => BottomNavigationBar(
        backgroundColor: AppColors.secondBacground,
        elevation: 1,
        currentIndex: controller.state.pageIndex,
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: AppColors.secondIcon,
        type: BottomNavigationBarType.fixed,
        items: bottomNavItems,
        onTap: controller.handlePageChanged,
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
            width: 50,
            height: 50,
            onPressed: controller.handlePublish,
          )
        : const SizedBox());

    /// 页面
    return Scaffold(
      backgroundColor: AppColors.mainBacground,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatButton,
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
