import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/routes/routes.dart';
import 'package:pinker/store/user.dart';

/// 检查是否登录
class RouteAuthMiddleware extends GetMiddleware {
  RouteAuthMiddleware();

  @override
  RouteSettings? redirect(String? route) {
    if (UserStore.to.token.isNotEmpty ||
        route == AppRoutes.frame ||
        UserStore.to.isOfflineLogin == true) {
      return null;
    }
    return const RouteSettings(name: AppRoutes.frame);
  }
}

/// 第一次欢迎页面
class RouteFrameMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (UserStore.to.isOfflineLogin == true) {
      return const RouteSettings(name: AppRoutes.application);
    } else {
      return null;
    }
  }
}
