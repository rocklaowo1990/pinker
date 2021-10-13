import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';

import 'entities/entities.dart';

/// 全局静态数据
class Global {
  /// 用户配置
  static UserLoginResponseEntity profile = UserLoginResponseEntity(
    accessToken: null,
  );

  /// 发布渠道
  // static String channel = "xiaomi";

  /// 是否 ios
  static bool isIOS = Platform.isIOS;

  /// android 设备信息
  // static late AndroidDeviceInfo androidDeviceInfo;

  /// ios 设备信息
  // static late IosDeviceInfo iosDeviceInfo;

  /// 包信息
  // static late PackageInfo packageInfo;

  /// 是否第一次打开
  static bool? isFirstOpen;

  /// 是否离线登录
  static bool isOfflineLogin = false;

  /// 是否 release
  // static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  /// init
  static Future init() async {
    // 运行初始
    WidgetsFlutterBinding.ensureInitialized();

    // 读取设备信息
    // DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    // if (Global.isIOS) {
    //   Global.iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    // } else {
    //   Global.androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    // }

    // 包信息
    // Global.packageInfo = await PackageInfo.fromPlatform();

    // 工具初始
    // await StorageUtil().init();
    // HttpUtil();

    // 读取设备第一次打开
    isFirstOpen = StorageUtil().getBool(storageDeviceFirstOpenKey);
    isFirstOpen ??= true;

    // 读取离线用户信息
    var _profileJSON = StorageUtil().getJSON(storageUserProfileKey);
    if (_profileJSON != null) {
      profile = UserLoginResponseEntity.fromJson(_profileJSON);
      isOfflineLogin = true;
    }

    // android 状态栏为透明的沉浸
    // if (Platform.isAndroid) {
    //   SystemUiOverlayStyle systemUiOverlayStyle =
    //       SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    //   SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    // }
  }

  // 保存用户已打开APP
  static saveAlreadyOpen() {
    StorageUtil().setBool(storageDeviceFirstOpenKey, false);
  }

  // 持久化 用户信息
  static Future<bool> saveProfile(UserLoginResponseEntity userResponse) {
    profile = userResponse;
    return StorageUtil().setJSON(storageUserProfileKey, userResponse.toJson());
  }
}
