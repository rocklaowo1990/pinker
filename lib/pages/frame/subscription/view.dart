import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/frame/subscription/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 标题部分组合
    Widget top = Column(
      children: [
        getTitle('推荐订阅'),
        const SizedBox(height: 20),
        getSpanSecond('当你关注某人后，你会在自己的主页看到他们的推文'),
      ],
    );

    Widget middle = Obx(() => Column(
          children: [
            for (int index = 0;
                index < controller.state.userList.value.list.length;
                index++)
              getUserList(
                  controller.state.userList.value.list[index].avatar,
                  controller.state.userList.value.list[index].userName,
                  controller.state.userList.value.list[index].nickName,
                  buttonPressed: () {
                controller.handleSubscribe(index);
              })
          ],
        ));

    /// 底部
    Widget bottom = getBottomBox(
      rightWidget: getButtonSheet(
        child: getSpan(Lang.next.tr),
        onPressed: controller.handleNext,
      ),
    );

    /// body 布局
    Widget body = Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              const SizedBox(height: 10),
              top,
              const SizedBox(height: 20),
              middle,
            ],
          ),
        ),
        bottom,
      ],
    );

    /// 布局
    return Scaffold(
      backgroundColor: AppColors.mainBacground,
      body: Obx(
        () => controller.frameController.state.pageIndex != -3
            ? Stack(
                // 遮罩层
                children: [
                  body,
                  Container(
                    color: Colors.black12,
                  )
                ],
              )
            : body,
      ),
    );
  }
}
