import 'package:dio/dio.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/global.dart';
import 'package:pinker/utils/utils.dart';

class AccountApi {
  /// 登陆API ///////////////////////////////////////////////////////////////////
  static Future<ResponseEntity> login(data) async {
    var response = await HttpUtil().postForm(
      '/api/account/login',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 检查账号是否重复 ////////////////////////////////////////////////////////////
  static Future<ResponseEntity> checkAccount(data) async {
    var response = await HttpUtil().get(
      '/api/account/checkAccountExist',
      queryParameters: data,
    );
    return ResponseEntity.fromJson(response);
  }

  /// 注册账号 //////////////////////////////////////////////////////////////////
  static Future<ResponseEntity> registerAccount(data) async {
    var response = await HttpUtil().postForm(
      '/api/account/register',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 验证账号是否存在（忘记密码使用）///////////////////////////////////////////////
  static Future<ResponseEntity> verificateAccount(data) async {
    var response = await HttpUtil().get(
      '/api/account/verificateAccount',
      queryParameters: data,
    );
    return ResponseEntity.fromJson(response);
  }

  /// 退出登陆 //////////////////////////////////////////////////////////////////
  static Future<ResponseEntity> logout() async {
    var response = await HttpUtil().postForm(
      '/api/account/logout',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 验证密码 //////////////////////////////////////////////////////////////////
  static Future<ResponseEntity> checkPassword(data) async {
    var response = await HttpUtil().postForm(
      '/api/account/CheckPassword',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 注销账号 //////////////////////////////////////////////////////////////////
  static Future<ResponseEntity> deleteAccount(data) async {
    var response = await HttpUtil().get(
      '/api/account/deleteAccount',
      queryParameters: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }
}
