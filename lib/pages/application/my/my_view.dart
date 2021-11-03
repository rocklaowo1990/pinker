import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/application/my/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class MyView extends GetView<MyController> {
  const MyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      _action('assets/svg/customer_service.svg'),
      _action('assets/svg/icon_mail_1.svg'),
      _action('assets/svg/icon_setting.svg'),
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
                child: SvgPicture.asset(
                  'assets/svg/avatar_default.svg',
                  width: 16.w,
                ),
              ),
            ),
          ),
          Row(children: actions),
        ],
      ),
    );

    /// appbar 组装
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

    /// 用户信息模块：点击去个人主页
    Widget userInfo = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/svg/avatar_default.svg', width: 30.w),
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
            SvgPicture.asset(
              'assets/svg/icon_right.svg',
              width: 8.h,
            )
          ],
        ),
      ],
    );

    /// 钱包模块的封装
    Widget _walletChild({
      required String title,
      required String svg,
      required String number,
      required String buttonText,
      required VoidCallback onPressed,
    }) {
      return Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(svg),
                SizedBox(width: 5.w),
                getSpan(title),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getSpan(number, size: 26.sp, fontWeight: FontWeight.w300),
                getButton(
                  child: getSpan(buttonText),
                  onPressed: onPressed,
                  width: 55.w,
                  height: 22.h,
                ),
              ],
            ),
          ],
        ),
      );
    }

    /// 钱包模块
    Widget wallet = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.secondBacground,
        borderRadius: BorderRadius.all(Radius.circular(8.w)),
      ),
      child: Column(
        children: [
          _walletChild(
            title: '钻石账户',
            svg: 'assets/svg/icon_diamond.svg',
            number: '0',
            buttonText: '购买钻石',
            onPressed: () {},
          ),
          Container(
            width: double.infinity,
            height: 0.5.h,
            color: AppColors.line,
          ),
          _walletChild(
            title: 'P币账户',
            svg: 'assets/svg/icon_money.svg',
            number: '0',
            buttonText: '立即提现',
            onPressed: () {},
          ),
        ],
      ),
    );

    /// 正在订阅模块的封装
    Widget _subscription({
      required String title,
      required String svg,
      required String number,
      required VoidCallback onPressed,
    }) {
      return getButton(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(svg),
                SizedBox(width: 4.w),
                getSpan(title),
              ],
            ),
            SizedBox(height: 10.h),
            getSpan(number, size: 20.sp),
          ],
        ),
        background: AppColors.secondBacground,
        onPressed: onPressed,
        radius: BorderRadius.all(
          Radius.circular(8.w),
        ),
        padding: EdgeInsets.all(8.w),
      );
    }

    /// 正在订阅模块组装
    Widget subscription = Row(children: [
      Expanded(
          child: _subscription(
        title: '正在订阅的用户',
        svg: 'assets/svg/icon_person_add.svg',
        number: '0',
        onPressed: () {},
      )),
      SizedBox(width: 5.h),
      Expanded(
          child: _subscription(
        title: '正在订阅的用户',
        svg: 'assets/svg/icon_person_add.svg',
        number: '0',
        onPressed: () {},
      )),
    ]);

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
              wallet,
              SizedBox(height: 5.h),
              subscription,
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

    Widget background = Column(
      children: [
        Expanded(
            child: Container(
          color: AppColors.mainColor,
        )),
        Expanded(
            child: Container(
          color: AppColors.mainBacground,
        )),
      ],
    );

    Widget body = Stack(
      children: [
        background,
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
