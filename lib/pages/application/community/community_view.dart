import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/pages/application/community/free/library.dart';
import 'package:pinker/pages/application/community/hot/library.dart';

import 'package:pinker/pages/application/community/library.dart';
import 'package:pinker/pages/application/community/new/library.dart';
import 'package:pinker/pages/application/community/sub/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommunityController>(
        init: CommunityController(),
        builder: (controller) {
          Widget left = getTabBar(
            controller.list,
            controller.state.pageIndexRx,
            controller: controller.tabController,
            onTap: controller.handleChangedTab,
          );

          Widget right = getSearchButton(onPressed: controller.handleSearch);

          /// AppBar
          AppBar appBar = getMainBar(
            left: Expanded(
              child: left,
              flex: 4,
            ),
            right: right,
          );

          /// body
          Widget body = PageView(
            controller: controller.pageController,
            children: const [
              ContentListFreeView(),
              ContentListSubView(),
              ContentListNewView(),
              ContentListHotView(),
            ],
            onPageChanged: controller.handlePageChanged,
            allowImplicitScrolling: true,
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
