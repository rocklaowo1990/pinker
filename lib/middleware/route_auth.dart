import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/routes/app_pages.dart';

/// 检查是否登录
class RouteAuthMiddleware extends GetMiddleware {
  RouteAuthMiddleware();

  @override
  RouteSettings? redirect(String? route) {
    return const RouteSettings(name: AppRoutes.index);
  }
}
