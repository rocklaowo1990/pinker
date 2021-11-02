import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/application/my/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class MyView extends StatelessWidget {
  const MyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 控制器
    final MyController controller = Get.put(MyController());

    /// 内部封装顶部右侧三个图标的方法
    Widget _action(String asset) {
      return getButton(
        child: SvgPicture.asset(asset),
        background: Colors.transparent,
        width: 33.h,
        height: 33.h,
        onPressed: controller.handleMail,
      );
    }

    /// appbar 的右侧三图标
    List<Widget> actions = [
      _action('assets/svg/ic_kefu.svg'),
      _action('assets/svg/ic_xinxi_2_white.svg'),
      _action('assets/svg/ic_sz.svg'),
    ];

    /// appbar 背景
    Widget appBarBacground = Obx(
      () => Opacity(
        opacity: controller.state.opacity,
        child: Container(
          width: double.infinity,
          height: 51.h,
          color: AppColors.mainColor,
        ),
      ),
    );

    /// appbar 内容
    Widget appBarChild = SizedBox(
      width: double.infinity,
      height: 40.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Obx(
              () => Opacity(
                opacity: controller.state.opacity,
                child: SvgPicture.asset('assets/svg/icons_1.svg', width: 16.w),
              ),
            ),
          ),
          Row(children: actions),
        ],
      ),
    );

    /// appbar
    Widget appBar = Stack(
      children: [
        appBarBacground,
        Column(
          children: [
            SizedBox(height: 11.h),
            appBarChild,
          ],
        )
      ],
    );

    // SliverAppBar appbar = SliverAppBar(
    //     backgroundColor: AppColors.mainColor,
    //     elevation: 0,
    //     forceElevated: false,
    //     systemOverlayStyle: const SystemUiOverlayStyle(
    //       statusBarColor: Colors.transparent,
    //       statusBarIconBrightness: Brightness.light,
    //       statusBarBrightness: Brightness.dark,
    //     ),
    //     // bottom: const BottomBar(),
    //     flexibleSpace: FlexibleSpaceBar(
    //       title: SvgPicture.asset(
    //         'assets/svg/icons_1.svg',
    //         width: 25.w,
    //       ),
    //       titlePadding: EdgeInsets.only(left: 8.w, top: 20.h, bottom: 8.h),
    //       background: Stack(
    //         children: [
    //           SvgPicture.asset(
    //             'assets/svg/tp_grbg_1.svg',
    //           ),
    //         ],
    //       ),
    //       centerTitle: false,
    //       collapseMode: CollapseMode.pin,
    //     ),
    //     expandedHeight: 97.h,
    //     floating: false,
    //     pinned: true,
    //     snap: false,
    //     actions: actions);

    // SliverFixedExtentList bodyChild = SliverFixedExtentList(
    //   delegate: SliverChildListDelegate(
    //     [
    //       SvgPicture.asset(
    //         'assets/svg/tp_grbg_2.svg',
    //       ),
    //       getSpan('text'),
    //       getSpan('text'),
    //       getSpan('text'),
    //       getSpan('text'),
    //       getSpan('text'),
    //       getSpan('text'),
    //       getSpan('text'),
    //       getSpan('text'),
    //       getSpan('text'),
    //       getSpan('text'),
    //       getSpan('text'),
    //       getSpan('text'),
    //       getSpan('text'),
    //       getSpan('text'),
    //       getSpan('text'),
    //     ],
    //   ),
    //   itemExtent: 50.0,
    // );

    Widget userInfo = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/svg/icons_1.svg', width: 30.w),
            SizedBox(width: 6.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getSpan('用户09812', size: 10.sp),
                getSpan('@Useroo1023'),
              ],
            ),
          ],
        ),
        Row(
          children: [
            getSpan('个人主页'),
            const Icon(
              Icons.chevron_right,
              color: AppColors.mainIcon,
            ),
          ],
        ),
      ],
    );

    /// body
    Widget bodyChild = SingleChildScrollView(
      controller: controller.scrollController,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.mainBacground,
          image: DecorationImage(
            image: AssetImage('assets/images/tp_1@3x.png'),
            alignment: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            children: [
              SizedBox(height: 50.h),
              userInfo,
              SizedBox(height: 15.h),
              Container(
                width: double.infinity,
                height: 100.h,
                decoration: BoxDecoration(
                  color: AppColors.secondBacground,
                  borderRadius: BorderRadius.all(Radius.circular(8.w)),
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                height: 100.h,
                decoration: BoxDecoration(
                  color: AppColors.secondBacground,
                  borderRadius: BorderRadius.all(Radius.circular(8.w)),
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                height: 100.h,
                decoration: BoxDecoration(
                  color: AppColors.secondBacground,
                  borderRadius: BorderRadius.all(Radius.circular(8.w)),
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                height: 100.h,
                decoration: BoxDecoration(
                  color: AppColors.secondBacground,
                  borderRadius: BorderRadius.all(Radius.circular(8.w)),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    Widget body = Stack(
      children: [
        bodyChild,
        appBar,
      ],
    );

    /// 页面
    return Scaffold(
      backgroundColor: AppColors.mainBacground,
      body: body,
    );
  }
}
