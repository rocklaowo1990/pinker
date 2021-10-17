import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/global.dart';
import 'lang/translation_service.dart';
import 'routes/app_pages.dart';
import 'utils/utils.dart';

Future<void> main() async {
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  await Global.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 填入设计稿中设备的屏幕尺寸,单位dp
    return ScreenUtilInit(
      designSize: const Size(187.5, 406),
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,

        /// 日志
        enableLog: true,
        logWriterCallback: Logger.write,

        /// 默认页面切换动画
        defaultTransition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),

        /// 路由
        getPages: AppPages.routes,
        unknownRoute: AppPages.unknown,

        /// 启动页面
        initialRoute: AppPages.initial,

        /// APP字典，多语言切换
        translations: TranslationService(), //字典
        locale: TranslationService.locale, // 默认语言
        fallbackLocale: TranslationService.fallbackLocale, // 备用语言

        /// 系统字典，用来改变系统组件的语言
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('zh', 'CN'), // 中文简体
          Locale('en', 'US'), // 美国英语
        ],

        /// 主题
        // theme: ThemeData.dark(),
      ),
    );
  }
}
