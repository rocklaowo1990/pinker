import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/pages/application/library.dart';
import 'package:pinker/pages/code_list/library.dart';
import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/pages/media/library.dart';
import 'package:pinker/pages/personal/library.dart';
import 'package:pinker/pages/publish/library.dart';
import 'package:pinker/pages/publish/reply/binding.dart';
import 'package:pinker/pages/publish/reply/view.dart';
import 'package:pinker/pages/recommend_user_list/library.dart';
import 'package:pinker/pages/setting/check_password/library.dart';
import 'package:pinker/pages/setting/count_list/library.dart';
import 'package:pinker/pages/setting/delete_account/library.dart';
import 'package:pinker/pages/setting/library.dart';
import 'package:pinker/pages/setting/money/library.dart';
import 'package:pinker/pages/setting/money/money_set/library.dart';
import 'package:pinker/pages/setting/set_email/library.dart';
import 'package:pinker/pages/setting/set_group/group_info/library.dart';
import 'package:pinker/pages/setting/set_group/library.dart';
import 'package:pinker/pages/setting/set_language/library.dart';
import 'package:pinker/pages/setting/set_password/library.dart';
import 'package:pinker/pages/setting/set_phone/library.dart';
import 'package:pinker/pages/setting/set_user_logo/library.dart';
import 'package:pinker/pages/setting/set_user_name/library.dart';
import 'package:pinker/pages/setting/verify/library.dart';
import 'package:pinker/pages/subscribe_list/library.dart';
import 'package:pinker/pages/unknown/library.dart';

import 'routes.dart';

class AppPages {
  static const initial = AppRoutes.frame;
  static List<String> history = [];
  static final RouteObserver<Route> observer = RouteObservers();

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
      children: [
        /// 发推
        GetPage(
            name: AppRoutes.publish,
            page: () => const PublishView(),
            binding: PublishBinding(),
            children: [
              GetPage(
                name: AppRoutes.reply,
                page: () => const ReplyView(),
                binding: ReplyBinding(),
              )
            ]),
      ],
    ),

    /// 我的订阅列表
    GetPage(
      name: AppRoutes.subscribeList,
      page: () => const SubscribeListView(),
      binding: SubscribeListBinding(),
    ),

    /// 推荐订阅
    GetPage(
      name: AppRoutes.recommendUserList,
      page: () => const RecommendUserListView(),
      binding: RecommendUserListBinding(),
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

    /// 区号选择
    GetPage(
      name: AppRoutes.personal,
      page: () => const PersonalView(),
      binding: PersonalBinding(),
    ),

    /// 媒体页面
    GetPage(
      name: AppRoutes.media,
      page: () => const MediaView(),
      binding: MediaBinding(),
      transition: Transition.noTransition,
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
          name: AppRoutes.money,
          page: () => const MoneyView(),
          binding: MoneyBinding(),
          children: [
            GetPage(
              name: AppRoutes.moneySet,
              page: () => const MoneySetView(),
              binding: MoneySetBinding(),
            ),
          ],
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
