import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/user.dart';
import 'package:pinker/global.dart';

import 'package:pinker/pages/index/index.dart';
import 'package:pinker/utils/utils.dart';

class IndexController extends GetxController {
  final pages = <String>['/signBefore', '/signIn', '/signUp'];

  final TextEditingController userCountController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();

  final FocusNode userCountFocusNode = FocusNode();
  final FocusNode userPasswordFocusNode = FocusNode();

  RxBool isShow = false.obs; //控制蒙版是否显示

  /// 去登陆页面按钮
  void handleGoSignInPage() {
    debugPrint(Global.isOfflineLogin.toString());
    isShow.value = true;
    // await Future.delayed(const Duration(milliseconds: 100));
    Get.toNamed(pages[1], id: 1);
  }

  /// 去注册页面按钮
  void handleGoSignUpPage() {
    isShow.value = true;
    Get.toNamed(pages[2], id: 1);
  }

  /// 去找回密码页面
  void handleGoForgetPasswordPage() {}

  /// 返回默认页面按钮
  void handleGoSignBeforePage() async {
    isShow.value = false;
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    // await Future.delayed(const Duration(milliseconds: 200));
    Get.back(id: 1);
  }

  /// 用户登陆
  void handleSignIn() async {
    /// 账号为空，退出
    if (userCountController.text.isEmpty) {
      FocusScope.of(Get.context!).requestFocus(userCountFocusNode);
      return;
    }

    /// 密码为空，退出
    if (userPasswordController.text.isEmpty) {
      FocusScope.of(Get.context!).requestFocus(userPasswordFocusNode);
      return;
    }

    /// 准备请求数据
    Map<String, String> data = {
      'account': userCountController.text,
      'password': duMD5(userPasswordController.text),
      'accountType': '1',
    };

    /// 等待请求结果
    UserLoginResponseEntity userProfile = await AccountApi.signIn(data: data);

    debugPrint(userProfile.code.toString());
    debugPrint(userProfile.msg);
    if (userProfile.code == 200) {
      Global.saveProfile(userProfile);
      Global.saveAlreadyOpen();
      Get.offAllNamed('/application');
    }

    debugPrint(Global.isOfflineLogin.toString());
  }

  GetPageRoute _getPageRoute({
    required RouteSettings settings,
    required Widget page,
  }) {
    return GetPageRoute(
      settings: settings,
      page: () => page,
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/signBefore') {
      return _getPageRoute(
        page: const SignBeforeView(),
        settings: settings,
      );
    } else if (settings.name == '/signIn') {
      return _getPageRoute(
        page: const SignInView(),
        settings: settings,
      );
    } else if (settings.name == '/signUp') {
      return _getPageRoute(
        page: const SignUpView(),
        settings: settings,
      );
    }

    return null;
  }

  @override
  void dispose() {
    userCountController.dispose();
    userPasswordController.dispose();

    userCountFocusNode.dispose();
    userPasswordFocusNode.dispose();

    super.dispose();
  }
}
