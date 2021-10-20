import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/utils/utils.dart';

class AccountApi {
  /// 登陆API
  static Future<UserLoginResponseEntity> login({
    data,
  }) async {
    var response = await HttpUtil().post(
      '/api/account/login',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
    );
    return UserLoginResponseEntity.fromJson(response);
  }

  /// 注册API
  static Future register({
    data,
  }) async {
    /// 获取APP相关信息
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    /// 获取设备信息
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    /// 注册需要传入的头部参数
    /// 系统，安卓还是IOS
    String? platform;

    /// 手机系统版本
    String? osversion;

    /// APP版本
    String? version = packageInfo.version;

    /// 机型
    String? model;

    /// 时间戳
    String? timestamp = DateTime.now().toString();

    /// token
    String? token = '';

    if (GetPlatform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      platform = 'android';
      osversion = 'Android ${androidInfo.version.sdkInt}';
      model = androidInfo.model;
    } else if (GetPlatform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      platform = 'ios';
      osversion = 'Android ${iosInfo.systemVersion}';
      model = iosInfo.model;
    }

    var response = await HttpUtil().post(
      '/api/common/sendSms',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'platform': platform,
        'osversion': osversion,
        'version': version,
        'model': model,
        'timestamp': timestamp,
        'token': token,
      }),
    );
    debugPrint(
        '"platform": $platform,"osversion": $osversion,"version": $version,"model": $model,"timestamp": $timestamp, "token": $token,');
    return UserLoginResponseEntity.fromJson(response);
  }
}
