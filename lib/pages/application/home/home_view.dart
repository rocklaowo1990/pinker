import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/application/home/library.dart';
import 'package:pinker/pages/dynamic/dynamic.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

    // 有数据的状态
    // Widget hadData = Obx(() => ListView.builder(
    //       itemCount: controller.state.showList.length,
    //       itemBuilder: (context, index) {
    //         return content(controller.state.showList[index]);
    //       },
    //     ));

    // 整体布局
    Widget _body = Obx(() => controller.state.showList.isEmpty
        ? noData
        : SmartRefresher(
            controller: controller.refreshController,
            enablePullUp: true,
            child: ListView.builder(
              itemCount: controller.state.showList.length,
              itemBuilder: (context, index) {
                return contentList(controller.state.showList[index]);
              },
            ),
            footer: CustomFooter(
              height: 80.h,
              loadStyle: LoadStyle.ShowWhenLoading,
              builder: (BuildContext context, LoadStatus? mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = getSpan(
                    "加载完成",
                    color: AppColors.secondText,
                  );
                } else if (mode == LoadStatus.loading) {
                  body = SizedBox(
                      width: 9.w,
                      height: 9.w,
                      child: CircularProgressIndicator(
                          backgroundColor: AppColors.mainIcon,
                          color: AppColors.mainColor,
                          strokeWidth: 1.w));
                } else if (mode == LoadStatus.failed) {
                  body = getSpan(
                    "加载失败！点击重试！",
                    color: AppColors.secondText,
                  );
                } else if (mode == LoadStatus.canLoading) {
                  body = getSpan(
                    "释放刷新",
                    color: AppColors.secondText,
                  );
                } else {
                  body = getSpan(
                    "没有更多数据了!",
                    color: AppColors.secondText,
                  );
                }
                return SizedBox(
                  height: 80.h,
                  child: Center(child: body),
                );
              },
            ),
            header: const WaterDropHeader(),
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
          ));

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
