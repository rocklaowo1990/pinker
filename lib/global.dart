import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

import 'package:pinker/entities/user.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';

/// 全局静态数据
class Global {
  /// 用户配置
  static String? token;

  /// 系统类型
  static String? platform;

  /// 手机系统版本
  static String? osversion;

  /// APP版本
  static String? version;

  /// 机型
  static String? model;

  /// android 设备信息
  // static late AndroidDeviceInfo androidDeviceInfo;

  /// ios 设备信息
  // static late IosDeviceInfo iosDeviceInfo;

  /// 包信息
  static PackageInfo? packageInfo;

  /// 是否第一次打开
  // static bool? isFirstOpen;

  /// 是否离线登录
  static bool isOfflineLogin = false;

  /// 是否 release
  // static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  /// init
  static Future init() async {
    /// 运行初始
    WidgetsFlutterBinding.ensureInitialized();

    /// 读取设备信息
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (GetPlatform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      Global.platform = 'android';
      Global.osversion = 'Android ${androidInfo.version.sdkInt}';
      Global.model = androidInfo.model;
    } else if (GetPlatform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      Global.platform = 'ios';
      Global.osversion = 'IOS ${iosInfo.systemVersion}';
      Global.model = iosInfo.model;
    }

    /// 包信息
    Global.packageInfo = await PackageInfo.fromPlatform();

    /// 工具初始
    await StorageUtil().init();
    HttpUtil();

    // 读取设备第一次打开
    // isFirstOpen = StorageUtil().getBool(storageDeviceFirstOpenKey);
    // isFirstOpen ??= true;

    // 读取离线用户信息
    var _profileJSON = StorageUtil().getJSON(storageUserProfileKey);
    if (_profileJSON != null) {
      Global.token = _profileJSON['data']['token'];
      isOfflineLogin = true;
    }
  }

  // 保存用户已打开APP
  // static saveAlreadyOpen() {
  //   StorageUtil().setBool(storageDeviceFirstOpenKey, false);
  // }

  // 持久化 用户信息
  static Future<bool> saveProfile(UserLoginResponseEntity profile) {
    profile = profile;
    return StorageUtil().setJSON(storageUserProfileKey, profile);
  }
}
