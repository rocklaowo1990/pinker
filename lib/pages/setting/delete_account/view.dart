import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/pages/setting/delete_account/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class DeleteAccountView extends GetView<DeleteAccountController> {
  const DeleteAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // appBar
    AppBar appBar = getLineBar('注销账号');

    // 按钮
    Widget button = getButtonMain(
      onPressed: controller.handleDeleteAccount,
      child: getSpan('注销账号'),
    );

    // body
    Widget body = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            getSpan('您即将开始注销您的 Pinker 账号，您的账号信息和公开个人资料将不再显示在 Pinker 的任何地方；'),
            const SizedBox(height: 10),
            getSpan('注销账号后您将失去所有的粉丝和关注者信息，您绑定的钱包信息将永久从服务器删除，账户余额也将被永久清空；'),
            const SizedBox(height: 10),
            getSpan('请确保没有任何正在审核中的充值或提现订单，以免造成损失；'),
            const SizedBox(height: 20),
            button,
          ],
        ),
      ),
    );

    /// 页面
    return Scaffold(
      backgroundColor: AppColors.secondBacground,
      appBar: appBar,
      body: body,
    );
  }
}
