import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/setting/count_list/library.dart';

import 'package:pinker/values/values.dart';

import 'package:pinker/widgets/widgets.dart';

class SetCountListView extends GetView<SetCountListController> {
  const SetCountListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 搜索框
    Widget searchBox = getInput(
      contentPadding: EdgeInsets.zero,
      type: Lang.inputSearch.tr,
      borderRadius: BorderRadius.zero,
      controller: controller.textController,
      focusNode: controller.focusNode,
      prefixIcon: SizedBox(
        width: 10.h,
        height: 10.h,
        child: Center(
          child: SvgPicture.asset(
            'assets/svg/icon_search_2.svg',
          ),
        ),
      ),
    );
    AppBar appBar = getAppBar(
      getSpan(controller.arguments.title, fontSize: 17),
      backgroundColor: AppColors.secondBacground,
      bottomHeight: 48,
    );

    /// body
    Widget body = Obx(() => controller.state.isLoading
        ? Center(
            child: Column(children: [
            SizedBox(height: 40.h),
            SizedBox(
                width: 9.w,
                height: 9.w,
                child: CircularProgressIndicator(
                    backgroundColor: AppColors.mainIcon,
                    color: AppColors.mainColor,
                    strokeWidth: 1.w)),
            SizedBox(height: 6.h),
            getSpan('加载中...', color: AppColors.secondText),
          ]))
        : Column(children: [
            searchBox,
            controller.state.showList.isEmpty
                ? Center(
                    child: Column(children: [
                    SizedBox(height: 20.h),
                    SvgPicture.asset('assets/svg/error_1.svg', width: 55.w),
                    SizedBox(height: 6.h),
                    getSpan('暂无数据', color: AppColors.secondText),
                  ]))
                : Expanded(
                    child: getRefresher(
                    controller: controller.refreshController,
                    child: ListView(
                        children: controller.state.showList
                            .map((item) => Container(
                                color: AppColors.secondBacground,
                                child: getUserList(item['avatar'],
                                    item['userName'], item['nickName'],
                                    buttonText: '移出', buttonPressed: () {
                                  controller.handleListOnTap(item);
                                })))
                            .toList()),
                    onLoading: controller.onLoading,
                    isFooter:
                        controller.state.showList.length < 20 ? false : true,
                    onRefresh: controller.onRefresh,
                  )),
          ]));

    return Scaffold(
      appBar: appBar,
      body: body,
      backgroundColor: AppColors.mainBacground,
    );
  }
}
