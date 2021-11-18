import 'package:get/get.dart';
import 'package:pinker/api/account.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/entities/response.dart';

import 'package:pinker/pages/setting/library.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';

import 'package:pinker/widgets/widgets.dart';

class SettingController extends GetxController {
  final state = LanguageState();
  final UserInfo? arguments = Get.arguments;

  /// 返回
  void handleGoSignBeforePage() {
    Get.back();
  }

  /// 去语言选择页面
  void handleGoLanguage() {
    Get.toNamed(AppRoutes.set + AppRoutes.language);
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

  /// 更换邮箱
  void handleSetEmail() {
    Get.toNamed(
      AppRoutes.set + AppRoutes.checkPassword,
      arguments: AppRoutes.setEmail,
    );
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
    ResponseEntity _logOut = await AccountApi.logout();
    if (_logOut.code == 200) {
      await futureMill(300);
      Get.back();
    } else {
      await futureMill(300);
      Get.back();
    }
    goLoginPage();
  }

  @override
  void onReady() {
    super.onReady();
    if (arguments != null) {
      state.userName = arguments!.userName ?? '';
      state.phone = arguments!.phone ?? '点击添加';
      state.email = arguments!.email ?? '点击添加';
      state.blockCount = arguments!.blockCount ?? 0;
      state.hiddenCount = arguments!.hiddenCount ?? 0;
    }
  }
}
