import 'package:get/get.dart';

import 'package:pinker/pages/application/index.dart';
import 'package:pinker/pages/frame/frame.dart';
import 'package:pinker/pages/setting/index.dart';
import 'package:pinker/pages/setting/language/index.dart';
import 'package:pinker/pages/unknown/index.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.frame;

  static final unknownRoute = GetPage(
    name: AppRoutes.unknownRoute,
    page: () => const UnknownView(),
    binding: UnknownBinding(),
  );

  static final List<GetPage> getPages = [
    /// APP首页
    GetPage(
      name: AppRoutes.application,
      page: () => const ApplicationView(),
      binding: ApplicationBinding(),
      // middlewares: [
      //   RouteAuthMiddleware(), //第一次登陆和没有token的处理
      // ],
    ),

    /// 初始页面框架，包含登陆，注册，初始
    GetPage(
      name: AppRoutes.frame,
      page: () => const FrameView(),
      binding: FrameBinding(),
    ),

    // /// 初始页面
    // GetPage(
    //   name: AppRoutes.index,
    //   page: () => const IndexView(),
    //   binding: IndexBinding(),
    // ),

    // /// 注册
    // GetPage(
    //   name: AppRoutes.register,
    //   page: () => const RegisterView(),
    //   binding: RegisterBinding(),
    // ),

    // /// 登陆
    // GetPage(
    //   name: AppRoutes.login,
    //   page: () => const LoginView(),
    //   binding: LoginBinding(),
    // ),

    /// 设置页面
    GetPage(
      name: AppRoutes.set,
      page: () => const SettingView(),
      binding: SettingBinding(),
      children: [
        GetPage(
          name: AppRoutes.language,
          page: () => const LanguageView(),
          binding: LanguageBinding(),
        ),
      ],
    ),
  ];
}
