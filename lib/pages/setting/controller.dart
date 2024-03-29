import 'package:get/get.dart';
import 'package:pinker/api/account.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/application/library.dart';

import 'package:pinker/pages/setting/library.dart';
import 'package:pinker/routes/routes.dart';

import 'package:pinker/utils/utils.dart';

import 'package:pinker/widgets/widgets.dart';

class SettingController extends GetxController {
  final LanguageState state = LanguageState();
  final ApplicationController? arguments = Get.arguments;

  /// 返回
  void handleGoSignBeforePage() {
    Get.back();
  }

  // 注销账号
  void handleDeltetAccount() {
    Get.toNamed(AppRoutes.set + AppRoutes.deleteAccount);
  }

  /// 去语言选择页面
  void handleSetLanguage() {
    Get.toNamed(AppRoutes.set + AppRoutes.language);
  }

  /// 设置水印
  void handleSetUserLogo() {
    Get.toNamed(AppRoutes.set + AppRoutes.setUserLogo);
  }

  /// 设置用户名
  void handleSetUserName() {
    Get.toNamed(AppRoutes.set + AppRoutes.setUserName);
  }

  /// 更换手机号码
  void handleSetPhone() {
    Get.toNamed(
      AppRoutes.set + AppRoutes.checkPassword,
      arguments: AppRoutes.setPhone,
    );
  }

  /// 屏蔽列表
  void handleBlockList() {
    Map<String, dynamic> _data = {
      'title': '屏蔽列表',
      'getCountUrl': '/api/user/blockUserList',
      'setCountUrl': '/api/user/block',
      'countType': 'blockCount',
      'secondTitle': '取消屏蔽',
      'dataName': 'isBlock',
    };

    SetCountListEntities data = SetCountListEntities.fromJson(_data);

    Get.toNamed(AppRoutes.set + AppRoutes.setCountList, arguments: data);
  }

  /// 隐藏列表
  void handleHiddenList() {
    Map<String, dynamic> _data = {
      'title': '隐藏列表',
      'getCountUrl': '/api/user/hideUserList',
      'setCountUrl': '/api/user/hide',
      'countType': 'hiddenCount',
      'secondTitle': '取消隐藏',
      'dataName': 'isHide',
    };

    SetCountListEntities data = SetCountListEntities.fromJson(_data);

    Get.toNamed(AppRoutes.set + AppRoutes.setCountList, arguments: data);
  }

  /// 更换邮箱
  void handleSetEmail() {
    Get.toNamed(
      AppRoutes.set + AppRoutes.checkPassword,
      arguments: AppRoutes.setEmail,
    );
  }

  /// 更换邮箱
  void handleMoney() {
    Get.toNamed(
      AppRoutes.set + AppRoutes.money,
      arguments: AppRoutes.setEmail,
    );
  }

  /// 更换密码
  void handleSetPassword() {
    Get.toNamed(AppRoutes.set + AppRoutes.setPassword);
  }

  /// 设置订阅组
  void handleSetGroup() {
    Get.toNamed(AppRoutes.set + AppRoutes.setGroup);
  }

  /// 退出登陆
  void handleSignOut() {
    getDialog(
      autoBack: true,
      child: DialogChild.alert(
        title: '退出登陆',
        content: '是否确认退出登陆',
        leftText: '取消',
        onPressedRight: _signOut,
        onPressedLeft: _back,
      ),
    );
  }

  void _back() {
    Get.back();
  }

  void _signOut() async {
    Get.back();
    getDialog();
    await AccountApi.logout();
    await futureMill(200);
    Get.back();
    goLoginPage();
  }

  @override
  void onReady() {
    super.onReady();

    interval(state.sendTimeRx, (value) {
      if (state.sendTime > 0) state.sendTime--;
    });
  }
}
