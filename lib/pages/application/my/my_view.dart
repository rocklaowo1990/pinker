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
    Widget _action(String asset, {VoidCallback? onPressed}) {
      return getButton(
        child: SvgPicture.asset(asset),
        background: Colors.transparent,
        width: 33.h,
        height: 33.h,
        onPressed: onPressed,
      );
    }

    /// appbar 的右侧三图标
    List<Widget> actions = [
      _action('assets/svg/customer_service.svg'),
      _action('assets/svg/icon_mail_1.svg'),
      _action(
        'assets/svg/icon_setting.svg',
        onPressed: controller.handleSetting,
      ),
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
                  child: getButton(
                    onPressed: () {},
                    width: 18.w,
                    height: 18.w,
                    child: Obx(
                      () => controller.state.avatar.isEmpty
                          ? SvgPicture.asset('assets/svg/avatar_default.svg',
                              width: 18.w)
                          : getImageBox(
                              controller.state.avatar,
                              shape: BoxShape.circle,
                              width: 18.w,
                              height: 18.w,
                            ),
                    ),
                  )),
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
            Obx(() => controller.state.avatar.isEmpty
                ? SvgPicture.asset('assets/svg/avatar_default.svg', width: 30.w)
                : getImageBox(
                    controller.state.avatar,
                    shape: BoxShape.circle,
                    width: 30.w,
                    height: 30.w,
                  )),
            SizedBox(width: 6.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => getSpan(controller.state.nickName, fontSize: 17)),
                Obx(() => getSpan('@${controller.state.userName}')),
              ],
            ),
          ],
        ),
        Row(
          children: [
            getSpan('个人主页'),
            SvgPicture.asset(
              'assets/svg/icon_right.svg',
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
        padding: EdgeInsets.all(8.w),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(svg),
                SizedBox(width: 5.w),
                getSpan(title),
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getSpan(number, fontSize: 40, fontWeight: FontWeight.w300),
                getButton(
                  child: getSpan(buttonText),
                  onPressed: onPressed,
                  width: 55.w,
                  height: 18.h,
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
          Obx(() => _walletChild(
                title: '钻石账户',
                svg: 'assets/svg/icon_diamond.svg',
                number: '${controller.state.diamondBalance}',
                buttonText: '购买钻石',
                onPressed: () {},
              )),
          Container(
            width: double.infinity,
            height: 0.5.h,
            color: AppColors.line,
          ),
          Obx(() => _walletChild(
                title: 'P币账户',
                svg: 'assets/svg/icon_diamond.svg',
                number: '${controller.state.pCoinBalance}',
                buttonText: '立即提现',
                onPressed: () {},
              )),
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
            SizedBox(height: 4.h),
            getSpan(number, fontSize: 32, fontWeight: FontWeight.w300),
          ],
        ),
        background: AppColors.secondBacground,
        onPressed: onPressed,
        borderRadius: BorderRadius.all(
          Radius.circular(8.w),
        ),
        padding: EdgeInsets.all(8.w),
      );
    }

    /// 正在订阅模块组装
    Widget subscription = Row(children: [
      Expanded(
        child: Obx(() => _subscription(
              title: '订阅的用户',
              svg: 'assets/svg/icon_person_add.svg',
              number: '${controller.state.followCount}',
              onPressed: () {},
            )),
      ),
      SizedBox(width: 5.h),
      Expanded(
        child: Obx(() => _subscription(
              title: '订阅的群聊',
              svg: 'assets/svg/icon_person_team.svg',
              number: '${controller.state.subChatCount}',
              onPressed: () {},
            )),
      ),
    ]);

    Widget _getButton({
      required String title,
      required String svg,
      required VoidCallback onPressed,
    }) {
      return getButton(
        onPressed: onPressed,
        overlayColor: Colors.transparent,
        background: Colors.transparent,
        child: Column(
          children: [
            SvgPicture.asset(svg),
            SizedBox(height: 5.h),
            getSpan(title),
          ],
        ),
      );
    }

    /// 底部功能模块
    Widget buttons = Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 12.w, bottom: 12.w),
      decoration: BoxDecoration(
        color: AppColors.secondBacground,
        borderRadius: BorderRadius.all(Radius.circular(8.w)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _getButton(
              title: '帐变记录',
              svg: 'assets/svg/my_account_record.svg',
              onPressed: () {},
            ),
          ),
          Expanded(
            child: _getButton(
              title: '消费记录',
              svg: 'assets/svg/my_expenses_record.svg',
              onPressed: () {},
            ),
          ),
          Expanded(
            child: _getButton(
              title: '银行卡',
              svg: 'assets/svg/my_bank_card.svg',
              onPressed: () {},
            ),
          ),
          Expanded(
            child: _getButton(
              title: '数字钱包',
              svg: 'assets/svg/my_digital_currency.svg',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );

    /// body
    Widget bodyChild = SingleChildScrollView(
      controller: controller.scrollController,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.mainBacground,
          image: DecorationImage(
            image: AssetImage(
              'assets/images/tp_1@3x.png',
            ),
            alignment: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            children: [
              SizedBox(height: 44.w),
              userInfo,
              SizedBox(height: 12.w),
              wallet,
              SizedBox(height: 5.h),
              subscription,
              SizedBox(height: 5.h),
              buttons,
            ],
          ),
        ),
      ),
    );

    /// 页面背景
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

    /// 页面组成
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
