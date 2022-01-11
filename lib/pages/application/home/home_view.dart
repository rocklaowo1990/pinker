import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/application/home/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        // appbar 顶部左侧
        Widget left = Container(
          child: getSpan(
            '首页',
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
          child: getButton(
            width: double.infinity,
            background: Colors.transparent,
            overlayColor: Colors.transparent,
            onPressed: controller.handleNoData,
            child: Column(
              children: [
                SizedBox(height: 40.h),
                SvgPicture.asset(
                  'assets/svg/error_4.svg',
                  width: 55.w,
                ),
                SizedBox(height: 6.h),
                getSpan('暂无数据', color: AppColors.secondText),
                SizedBox(height: 2.h),
                getSpan('轻触屏幕重试', color: AppColors.secondText),
              ],
            ),
          ),
        );

        Widget swiper = SizedBox(
          height: 125.h,
          width: double.infinity,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.thirdIcon,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.w),
                  ),
                ),
              );
            },
            itemCount: 3,
            viewportFraction: 0.8,
            scale: 0.9,
            pagination: const SwiperPagination(),
          ),
        );

        Widget _warp() {
          return getButton(
            background: Colors.transparent,
            overlayColor: Colors.transparent,
            onPressed: () {},
            width: 187.5.w / 4,
            child: Column(
              children: [
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: AppColors.thirdIcon,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.w),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                getSpan('text'),
              ],
            ),
          );
        }

        Widget _activity() {
          return Container(
            padding: EdgeInsets.all(9.w),
            color: AppColors.secondBacground,
            child: Row(
              children: [
                Container(
                  width: 75.w,
                  height: 64.w,
                  decoration: BoxDecoration(
                    color: AppColors.thirdIcon,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.w),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: getSpan(
                          '这里是文件的表体这里是文件的表体这里是文件的表体这里是文件的表体',
                          fontSize: 17,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 3.w),
                      SizedBox(
                        width: double.infinity,
                        child: getSpan('1777 人参与', color: AppColors.mainColor),
                      ),
                      SizedBox(height: 2.w),
                      SizedBox(
                        width: double.infinity,
                        child: getSpan('活动日期：', color: AppColors.secondText),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child:
                            getSpan('09/09-09/09', color: AppColors.secondText),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        Widget activity = Column(
          children: [
            _activity(),
            _activity(),
            _activity(),
          ],
        );

        Widget warp = Container(
          color: AppColors.secondBacground,
          padding: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
          child: Wrap(
            runSpacing: 16.h,
            children: [
              _warp(),
              _warp(),
              _warp(),
              _warp(),
              _warp(),
              _warp(),
              _warp(),
              _warp(),
            ],
          ),
        );

        // 整体布局
        Widget _body = Obx(
          () => controller.applicationController.state.contentListHome.value
                  .list.isEmpty
              ? noData
              : getRefresher(
                  controller: controller.refreshController,
                  child: ListView(
                    children: [
                      SizedBox(height: 10.h),
                      swiper,
                      SizedBox(height: 10.h),
                      warp,
                      SizedBox(height: 10.h),
                      activity,
                      SizedBox(height: 10.h),
                      for (int index = 0;
                          index <
                              controller.applicationController.state
                                  .contentListHome.value.list.length;
                          index++)
                        getContentListView(
                            controller
                                .applicationController.state.contentListHome,
                            index),
                    ],
                  ),
                  onLoading: controller.onLoading,
                  onRefresh: controller.onRefresh,
                ),
        );

        /// body
        Widget body = Obx(() =>
            controller.applicationController.state.isLoadingHome
                ? loading
                : _body);

        /// 页面
        return Scaffold(
          backgroundColor: AppColors.mainBacground,
          appBar: appBar,
          body: body,
        );
      },
    );
  }
}
