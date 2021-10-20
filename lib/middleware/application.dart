import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/global.dart';
import 'package:pinker/routes/app_pages.dart';

/// 检查是否登录
class RouteAuthMiddleware extends GetMiddleware {
  RouteAuthMiddleware();

  @override
  RouteSettings? redirect(String? route) {
    if (Global.token != null ||
        route == AppRoutes.frame ||
        Global.isOfflineLogin == true) {
      return null;
    }
    return const RouteSettings(name: AppRoutes.frame);
  }
}

/// 第一次欢迎页面
class RouteFrameMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (Global.isOfflineLogin == true) {
      return const RouteSettings(name: AppRoutes.application);
    } else {
      return null;
    }
  }
}
