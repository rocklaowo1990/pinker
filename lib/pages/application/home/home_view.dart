import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/application/home/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // appbar 顶部左侧
    Widget left = Container(
      child: getSpan(
        '订阅',
        fontSize: 17,
        color: AppColors.mainColor,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.only(top: 14, bottom: 14),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.6.w, color: AppColors.mainColor),
        ),
      ),
    );

    // appbar 右侧按钮
    Widget right = getButton(
      child: SvgPicture.asset(
        'assets/svg/icon_mail_3.svg',
      ),
      background: Colors.transparent,
      width: 33.h,
      height: 33.h,
      onPressed: controller.handleMail,
    );

    /// AppBar
    AppBar appBar = getMainBar(
      left: left,
      right: right,
    );

    // loading时显示转圈圈
    Widget loading = Center(
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
    ]));

    // 没有数据的时候，显示暂无数据
    Widget noData = Center(
      child: Column(
        children: [
          SizedBox(height: 40.h),
          SvgPicture.asset(
            'assets/svg/error_4.svg',
            width: 55.w,
          ),
          SizedBox(height: 6.h),
          getSpan('暂无数据', color: AppColors.secondText),
        ],
      ),
    );

    // 有数据的首页展示
    // Widget hadData = NotificationListener<ScrollNotification>(
    //   // 添加 NotificationListener 作为父容器
    //   onNotification: (scrollNotification) {
    //     // 注册通知回调
    //     if (scrollNotification is ScrollStartNotification) {
    //       // 滚动开始
    //       // print('Scroll Start');
    //     } else if (scrollNotification is ScrollUpdateNotification) {
    //       // 滚动位置更新
    //       // print('Scroll Update');
    //       // print(scrollNotification.metrics.extentBefore);
    //       // print(scrollNotification.metrics.extentAfter);
    //       // print(scrollNotification.metrics.extentInside);
    //       // print(scrollNotification.metrics.maxScrollExtent);
    //       // print(scrollNotification.metrics.minScrollExtent);
    //       // print(scrollNotification.metrics.outOfRange);
    //       // print(scrollNotification.metrics.viewportDimension);
    //       // print(scrollNotification.metrics.hasContentDimensions);
    //     } else if (scrollNotification is ScrollEndNotification) {
    //       // 滚动结束
    //       // print('Scroll End');
    //       // print(scrollNotification.metrics);
    //     }
    //     return true;
    //   },

    //   child: Obx(() => ListView.builder(
    //         itemCount: controller.state.showList.length,
    //         itemBuilder: (context, index) {
    //           RenderBox? renderBox = context.findAncestorRenderObjectOfType();

    //           final positionsRed = renderBox!.localToGlobal(const Offset(0, 0));

    //           if (controller.state.showList[index].works!.video!.url != null) {
    //             print("$index:${positionsRed.dy}");
    //             print(controller.state.showList[index].works!.video!.url);
    //             controller.videoPlayerController =
    //                 VideoPlayerController.network(
    //                     controller.state.showList[index].works!.video!.url!);
    //           }

    //           return content(controller.state.showList[index],
    //               controller.videoPlayerController);
    //         },
    //       )),
    // );
    Widget hadData = Obx(() => ListView.builder(
          itemCount: controller.state.showList.length,
          itemBuilder: (context, index) {
            return content(controller.state.showList[index]);
          },
        ));

    // 整体布局
    Widget _body =
        Obx(() => controller.state.showList.isEmpty ? noData : hadData);

    /// body
    Widget body = Obx(() => controller.state.isLoading ? loading : _body);

    /// 页面
    return Scaffold(
      backgroundColor: AppColors.mainBacground,
      appBar: appBar,
      body: body,
    );
  }
}
