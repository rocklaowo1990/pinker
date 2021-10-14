import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'utils/utils.dart';

void main() {
  runApp(const MyApp());
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
        transitionDuration: const Duration(milliseconds: 400),

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
        // theme: appThemeData,
      ),
    );
  }
}

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  String title;

  HomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
