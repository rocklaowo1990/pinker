import 'package:get/get.dart';

import 'package:pinker/pages/application/library.dart';
import 'package:pinker/pages/code_list/library.dart';
import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/pages/setting/check_password/library.dart';
import 'package:pinker/pages/setting/count_list/binding.dart';
import 'package:pinker/pages/setting/count_list/library.dart';
import 'package:pinker/pages/setting/delete_account/library.dart';

import 'package:pinker/pages/setting/library.dart';
import 'package:pinker/pages/setting/set_email/library.dart';
import 'package:pinker/pages/setting/set_group/group_info/binding.dart';
import 'package:pinker/pages/setting/set_group/group_info/view.dart';
import 'package:pinker/pages/setting/set_group/library.dart';
import 'package:pinker/pages/setting/set_language/library.dart';
import 'package:pinker/pages/setting/set_password/binding.dart';
import 'package:pinker/pages/setting/set_password/view.dart';

import 'package:pinker/pages/setting/set_phone/library.dart';
import 'package:pinker/pages/setting/set_user_logo/library.dart';

import 'package:pinker/pages/setting/set_user_name/library.dart';
import 'package:pinker/pages/setting/verify/library.dart';

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
          name: AppRoutes.setCountList,
          page: () => const SetCountListView(),
          binding: SetCountListBinding(),
        ),
        GetPage(
          name: AppRoutes.setUserLogo,
          page: () => const SetUserLogoView(),
          binding: SetUserLogoBinding(),
        ),
        GetPage(
          name: AppRoutes.deleteAccount,
          page: () => const DeleteAccountView(),
          binding: DeleteAccountBinding(),
        ),
        GetPage(
          name: AppRoutes.setUserName,
          page: () => const SetUserNameView(),
          binding: SetUserNameBinding(),
        ),
        GetPage(
          name: AppRoutes.setPassword,
          page: () => const SetPasswordView(),
          binding: SetPasswordBinding(),
        ),
        GetPage(
          name: AppRoutes.setGroup,
          page: () => const SetGroupView(),
          binding: SetGroupBinding(),
          children: [
            GetPage(
              name: AppRoutes.setGroupInfo,
              page: () => const SetGroupInfoView(),
              binding: SetGroupInfoBinding(),
            ),
          ],
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
            GetPage(
              name: AppRoutes.setEmail,
              page: () => const SetEmailView(),
              binding: SetEmailBinding(),
            ),
            GetPage(
              name: AppRoutes.setVerify,
              page: () => const SetVerifyView(),
              binding: SetVerifyBinding(),
            ),
          ],
        ),
      ],
    ),
  ];
}
