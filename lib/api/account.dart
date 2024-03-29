import 'package:dio/dio.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/store/store.dart';
import 'package:pinker/utils/utils.dart';

class AccountApi {
  /// 登陆API ///////////////////////////////////////////////////////////////////
  static Future<ResponseEntity> login({
    required String account,
    required String password,
    required String accountType,
    int? pushId,
  }) async {
    var response = await HttpUtil().postForm(
      '/api/account/login',
      data: {
        'account': account,
        'password': password,
        'accountType': accountType,
        'pushId': pushId,
      },
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 检查账号是否重复 ////////////////////////////////////////////////////////////
  static Future<ResponseEntity> checkAccount({
    required String account,
    required int accountType,
    String? areaCode,
  }) async {
    var response = await HttpUtil().get(
      '/api/common/checkAccount',
      queryParameters: {
        'account': account,
        'accountType': accountType,
        'areaCode': areaCode,
      },
    );
    return ResponseEntity.fromJson(response);
  }

  /// 注册账号 //////////////////////////////////////////////////////////////////
  static Future<ResponseEntity> register({
    required String account,
    required int accountType,
    required int birthday,
    required String code,
    required String password,
    String? inviteCode,
    required String areaCode,
    int? pushId,
  }) async {
    var response = await HttpUtil().postForm(
      '/api/account/register',
      data: {
        'account': account,
        'accountType': accountType,
        'birthday': birthday,
        'code': code,
        'password': password,
        'inviteCode': inviteCode,
        'areaCode': areaCode,
        'pushId': pushId,
      },
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
        'token': UserStore.to.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 验证密码 //////////////////////////////////////////////////////////////////
  static Future<ResponseEntity> checkPassword({
    required int type,
    required String password,
  }) async {
    var response = await HttpUtil().postForm(
      '/api/account/CheckPassword',
      data: {
        'type': type,
        'password': password,
      },
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': UserStore.to.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 注销账号 //////////////////////////////////////////////////////////////////
  static Future<ResponseEntity> deleteAccount({
    required String code,
    required String password,
  }) async {
    var response = await HttpUtil().get(
      '/api/account/deleteAccount',
      queryParameters: {
        'code': code,
        'password': password,
      },
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': UserStore.to.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }
}
