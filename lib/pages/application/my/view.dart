import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/application/my/library.dart';
import 'package:pinker/values/colors.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyView extends StatelessWidget {
  const MyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyController>(
        init: MyController(),
        builder: (controller) {
          /// 内部封装顶部右侧三个图标的方法
          Widget _action(String asset, {VoidCallback? onPressed}) {
            return getButton(
              child: SvgPicture.asset(asset),
              background: Colors.transparent,
              width: 60,
              height: 60,
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

          /// appbar 内容
          Widget appBarChild = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Obx(
                  () => Opacity(
                      opacity: controller.state.opacity,
                      child: getButton(
                        onPressed: controller.handlePersonal,
                        width: 40,
                        height: 32,
                        child: getNetworkImageBox(
                          controller.applicationController.state.userInfo.value
                              .avatar,
                          shape: BoxShape.circle,
                          width: 32,
                          height: 32,
                        ),
                      )),
                ),
              ),
              Row(children: actions),
            ],
          );

          /// appbar 组装
          Widget appBar = Obx(
            () => Container(
              width: double.infinity,
              color: controller.state.opacity >= 1
                  ? AppColors.mainColor
                  : Colors.transparent,
              child: SafeArea(
                child: appBarChild,
              ),
            ),
          );

          /// 用户信息模块：点击去个人主页
          Widget userInfo = getButton(
            background: Colors.transparent,
            overlayColor: Colors.transparent,
            onPressed: controller.handlePersonal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(() => getNetworkImageBox(
                          controller.applicationController.state.userInfo.value
                              .avatar,
                          shape: BoxShape.circle,
                          width: 60,
                          height: 60,
                        )),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => getTitle(
                              controller.applicationController.state.userInfo
                                  .value.nickName,
                            )),
                        Obx(() => getSpan(
                            '@${controller.applicationController.state.userInfo.value.userName}')),
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
            ),
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
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(svg),
                      const SizedBox(width: 5),
                      getSpan(title),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getSpan(number,
                          fontSize: 36, fontWeight: FontWeight.w300),
                      getButtonSheet(
                        child: getSpan(buttonText),
                        onPressed: onPressed,

                        // height: 18,
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
            decoration: const BoxDecoration(
              color: AppColors.secondBacground,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              children: [
                Obx(() => _walletChild(
                      title: '钻石账户',
                      svg: 'assets/svg/icon_diamond.svg',
                      number: controller.applicationController.state.userInfo
                          .value.diamondBalance,
                      buttonText: '充值',
                      onPressed: controller.handleDiamond,
                    )),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: AppColors.line,
                ),
                Obx(() => _walletChild(
                      title: 'P币账户',
                      svg: 'assets/svg/icon_diamond.svg',
                      number: controller.applicationController.state.userInfo
                          .value.pCoinBalance,
                      buttonText: '提现',
                      onPressed: controller.handleP,
                    )),
              ],
            ),
          );

          /// 正在订阅模块的封装
          Widget _userListBox({
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
                      const SizedBox(width: 4),
                      getSpan(title),
                    ],
                  ),
                  const SizedBox(height: 10),
                  getSpan(number, fontSize: 32, fontWeight: FontWeight.w300),
                ],
              ),
              background: AppColors.secondBacground,
              onPressed: onPressed,
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
            );
          }

          /// 正在订阅模块组装
          Widget subscription = Row(children: [
            Expanded(
              child: Obx(() => _userListBox(
                    title: '订阅的用户',
                    svg: 'assets/svg/icon_person_add.svg',
                    number:
                        '${controller.applicationController.state.userInfo.value.followCount}',
                    onPressed: controller.handleSubscribeList,
                  )),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Obx(() => _userListBox(
                    title: '订阅的群聊',
                    svg: 'assets/svg/icon_person_team.svg',
                    number:
                        '${controller.applicationController.state.userInfo.value.subChatCount}',
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
                  const SizedBox(height: 10),
                  getSpan(title),
                ],
              ),
            );
          }

          /// 底部功能模块
          Widget buttons = Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            decoration: const BoxDecoration(
              color: AppColors.secondBacground,
              borderRadius: BorderRadius.all(Radius.circular(16)),
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
          Widget bodyChild = getRefresher(
            controller: controller.refreshController,
            scrollController: controller.scrollController,
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.mainBacground,
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/my_bac.png',
                    ),
                    alignment: Alignment.topCenter,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        userInfo,
                        const SizedBox(height: 20),
                        wallet,
                        const SizedBox(height: 10),
                        subscription,
                        const SizedBox(height: 10),
                        buttons,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            isFooter: false,
            onRefresh: controller.onRefresh,
            header: const WaterDropMaterialHeader(
              backgroundColor: AppColors.mainColor,
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
            body: body,
          );
        });
  }
}
