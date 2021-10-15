import 'package:get/get.dart';
import 'package:pinker/middleware/middleware.dart';
import 'package:pinker/pages/application/index.dart';
import 'package:pinker/pages/index/index.dart';

import 'package:pinker/pages/unknown/index.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.initial;

  static final unknown = GetPage(
    name: AppRoutes.unknown,
    page: () => const UnknownView(),
  );

  static final List<GetPage> routes = [
    /// 去首页：是否第一次打开，是否有token
    GetPage(
      name: AppRoutes.initial,
      page: () => const ApplicationView(),
      binding: ApplicationBinding(),
      middlewares: [
        RouteAuthMiddleware(), //第一次登陆和没有token的处理
      ],
    ),

    /// APP 主页
    GetPage(
      name: AppRoutes.application,
      page: () => const ApplicationView(),
      binding: ApplicationBinding(),
    ),

    /// 初始页面框架，包含登陆，注册，初始
    GetPage(
      name: AppRoutes.index,
      page: () => const IndexView(),
      binding: IndexBinding(),
    ),
  ];
}
