import 'package:dio/dio.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/global.dart';

import 'package:pinker/utils/utils.dart';

class UserApi {
  /// 推荐用户列表（注册）/////////////////////////////////////////////////////////
  static Future<ResponseEntity> list(
    Map<String, dynamic> data,
  ) async {
    // 请求
    var response = await HttpUtil().get(
      '/api/user/list',
      queryParameters: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
    );

    return ResponseEntity.fromJson(response);
  }

  /// 订阅用户组 ////////////////////////////////////////////////////////////////
  static Future<ResponseEntity> subscribeGroup(data) async {
    // 请求
    var response = await HttpUtil().postForm(
      '/api/user/subscribeGroup',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
    );

    return ResponseEntity.fromJson(response);
  }

  /// 更新用户信息 ///////////////////////////////////////////////////////////////
  static Future<ResponseEntity> updateUserInfo(
    Map<String, dynamic> data,
  ) async {
    // 请求
    var response = await HttpUtil().postForm(
      '/api/user/updateUserInfo',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
    );

    return ResponseEntity.fromJson(response);
  }

  /// 获取用户信息（我的） ////////////////////////////////////////////////////////
  static Future<ResponseEntity> info() async {
    // 请求
    var response = await HttpUtil().get(
      '/api/user/info',
      options: Options(headers: {
        'token': Global.token,
      }),
    );

    return ResponseEntity.fromJson(response);
  }

  /// 重置密码 //////////////////////////////////////////////////////////////////
  static Future<ResponseEntity> resetPassword(data) async {
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

  /// 设置用户名 ////////////////////////////////////////////////////////////////
  static Future<ResponseEntity> setUserName(data) async {
    // 请求
    var response = await HttpUtil().postForm(
      '/api/user/setUserName',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
      data: data,
    );

    return ResponseEntity.fromJson(response);
  }

  /// 设置手机号码 //////////////////////////////////////////////////////////////
  static Future<ResponseEntity> setMobile(data) async {
    // 请求
    var response = await HttpUtil().postForm(
      '/api/user/setMobile',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
      data: data,
    );

    return ResponseEntity.fromJson(response);
  }

  /// 设置邮箱地址 //////////////////////////////////////////////////////////////
  static Future<ResponseEntity> setEmail(Map<String, dynamic> data) async {
    // 请求
    var response = await HttpUtil().postForm(
      '/api/user/setEmail',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
      data: data,
    );
    return ResponseEntity.fromJson(response);
  }

  /// 设置用户密码 //////////////////////////////////////////////////////////////
  static Future<ResponseEntity> setPassword(Map<String, dynamic> data) async {
    // 请求
    var response = await HttpUtil().postForm(
      '/api/user/setPassword',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
      data: data,
    );
    return ResponseEntity.fromJson(response);
  }

  /// 已屏蔽的用户列表 ///////////////////////////////////////////////////////////
  /// 屏蔽列表地址：'/api/user/blockUserList'
  /// 隐藏列表地址：'/api/user/hideUserList'
  static Future<ResponseEntity> getCountList(
    String apiUrl,
    Map<String, dynamic> data,
  ) async {
    // 请求
    var response = await HttpUtil().get(
      apiUrl,
      options: Options(headers: {
        'token': Global.token,
      }),
      queryParameters: data,
    );
    return ResponseEntity.fromJson(response);
  }

  /// 屏蔽用户/ 隐藏用户 /////////////////////
  /// 这里是操作屏蔽和隐藏
  /// 隐藏：'/api/user/hide'
  /// 屏蔽：'/api/user/block'
  /// data：这里直接放到一起，通过不同的参数去区分
  static Future<ResponseEntity> blockHide(
    String apiUrl,
    Map<String, dynamic> data,
  ) async {
    // 请求
    var response = await HttpUtil().postForm(
      apiUrl,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
      data: data,
    );
    return ResponseEntity.fromJson(response);
  }

  /// 获取水印设计 //////////////////////////////////////////////////////////////
  static Future<ResponseEntity> getUserLogo() async {
    // 请求
    var response = await HttpUtil().postForm(
      '/api/user/getUserLogo',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 获取水印设计 //////////////////////////////////////////////////////////////
  static Future<ResponseEntity> setUserLogo(data) async {
    // 请求
    var response = await HttpUtil().postForm(
      '/api/user/setUserLogo',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
      data: data,
    );
    return ResponseEntity.fromJson(response);
  }
}
