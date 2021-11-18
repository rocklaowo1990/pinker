import 'package:get/get.dart';

import 'package:pinker/pages/application/library.dart';
import 'package:pinker/pages/code_list/library.dart';
import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/pages/setting/check_password/library.dart';
import 'package:pinker/pages/setting/library.dart';
import 'package:pinker/pages/setting/set_language/library.dart';
import 'package:pinker/pages/setting/set_phone/binding.dart';
import 'package:pinker/pages/setting/set_phone/library.dart';
import 'package:pinker/pages/setting/set_user_name/library.dart';

import 'package:pinker/pages/unknown/library.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.frame;

  static final unknownRoute = GetPage(
    name: AppRoutes.unknownRoute,
    page: () => const UnknownView(),
    binding: UnknownBinding(),
  );

  static final List<GetPage> getPages = [
    /// APP首页框架
    GetPage(
      name: AppRoutes.application,
      page: () => const ApplicationView(),
      binding: ApplicationBinding(),
    ),

    /// 初始页面框架，包含登陆，注册，初始
    GetPage(
      name: AppRoutes.frame,
      page: () => const FrameView(),
      binding: FrameBinding(),
    ),

    /// 区号选择
    GetPage(
      name: AppRoutes.codeList,
      page: () => const CodeListView(),
      binding: CodeListBinding(),
    ),

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
        GetPage(
          name: AppRoutes.setUserName,
          page: () => const SetUserNameView(),
          binding: SetUserNameBinding(),
        ),
        GetPage(
          name: AppRoutes.checkPassword,
          page: () => const CheckPasswordView(),
          binding: CheckPasswordBinding(),
          children: [
            GetPage(
              name: AppRoutes.setPhone,
              page: () => const SetPhoneView(),
              binding: SetPhoneBinding(),
            ),
          ],
        ),
      ],
    ),
  ];
}
