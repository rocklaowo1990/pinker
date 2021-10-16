import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/global.dart';

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
        // initialBinding: SplashBinding(),
        // home: SplashPage(),

        /// 多语言
        // locale: TranslationService.locale,
        // fallbackLocale: TranslationService.fallbackLocale,
        // translations: TranslationService(),

        /// 主题
        theme: ThemeData.dark(),
      ),
    );
  }
}
