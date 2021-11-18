import 'package:dio/dio.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';

class UserApi {
  /// 推荐用户列表（注册）
  static Future<ResponseEntity> list(
    Map<String, dynamic> data,
  ) async {
    // 读取token
    String token = StorageUtil().getJSON(storageUserTokenKey);
    // 请求
    var response = await HttpUtil().get(
      '/api/user/list',
      queryParameters: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': token,
      }),
    );

    return ResponseEntity.fromJson(response);
  }

  /// 订阅用户组
  static Future<ResponseEntity> subscribeGroup(
      Map<String, dynamic> data) async {
    // 读取token
    String token = StorageUtil().getJSON(storageUserTokenKey);
    // 请求
    var response = await HttpUtil().postForm(
      '/api/user/subscribeGroup',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': token,
      }),
    );

    return ResponseEntity.fromJson(response);
  }

  /// 更新用户信息
  static Future<ResponseEntity> updateUserInfo(
    Map<String, dynamic> data,
  ) async {
    // 读取token
    String token = StorageUtil().getJSON(storageUserTokenKey);
    // 请求
    var response = await HttpUtil().postForm(
      '/api/user/updateUserInfo',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': token,
      }),
    );

    return ResponseEntity.fromJson(response);
  }

  /// 获取用户信息（我的）
  static Future<ResponseEntity> info() async {
    // 读取token
    String token = StorageUtil().getJSON(storageUserTokenKey);
    // 请求
    var response = await HttpUtil().get(
      '/api/user/info',
      options: Options(headers: {
        'token': token,
      }),
    );

    return ResponseEntity.fromJson(response);
  }

  /// 重置密码
  static Future<ResponseEntity> resetPassword(
    Map<String, dynamic> data,
  ) async {
    // 请求
    var response = await HttpUtil().postForm(
      '/api/user/resetPassword',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
      data: data,
    );

    return ResponseEntity.fromJson(response);
  }

  /// 设置用户名
  static Future<ResponseEntity> setUserName(
    Map<String, dynamic> data,
  ) async {
    // 读取token
    String token = StorageUtil().getJSON(storageUserTokenKey);
    // 请求
    var response = await HttpUtil().postForm(
      '/api/user/setUserName',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': token,
      }),
      data: data,
    );

    return ResponseEntity.fromJson(response);
  }
}
