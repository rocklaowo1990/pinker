import 'package:dio/dio.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';

class SubscribeGroupApi {
  /// 分组列表 /////////////////////////////////////////////////////////////////
  static Future<ResponseEntity> list({Map<String, dynamic>? data}) async {
    // 读取token
    String token = StorageUtil().getJSON(storageUserTokenKey);
    var response = await HttpUtil().get(
      '/api/subscribeGroup/list',
      options: Options(headers: {
        'token': token,
      }),
      queryParameters: data,
    );
    return ResponseEntity.fromJson(response);
  }

  /// 修改分组信息 //////////////////////////////////////////////////////////////
  static Future<ResponseEntity> update(data) async {
    // 读取token
    String token = StorageUtil().getJSON(storageUserTokenKey);
    var response = await HttpUtil().postForm(
      '/api/subscribeGroup/update',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': token,
      }),
      data: data,
    );
    return ResponseEntity.fromJson(response);
  }

  /// 修改分组信息 //////////////////////////////////////////////////////////////
  static Future<ResponseEntity> create(data) async {
    // 读取token
    String token = StorageUtil().getJSON(storageUserTokenKey);
    var response = await HttpUtil().postForm(
      '/api/subscribeGroup/create',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': token,
      }),
      data: data,
    );
    return ResponseEntity.fromJson(response);
  }
}
