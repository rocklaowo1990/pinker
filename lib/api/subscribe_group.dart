import 'package:dio/dio.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/global.dart';
import 'package:pinker/utils/utils.dart';

class SubscribeGroupApi {
  /// 分组列表 /////////////////////////////////////////////////////////////////
  static Future<ResponseEntity> list({Map<String, dynamic>? data}) async {
    var response = await HttpUtil().get(
      '/api/subscribeGroup/list',
      options: Options(headers: {
        'token': Global.token,
      }),
      queryParameters: data,
    );
    return ResponseEntity.fromJson(response);
  }

  /// 修改分组信息 //////////////////////////////////////////////////////////////
  static Future<ResponseEntity> update(data) async {
    var response = await HttpUtil().postForm(
      '/api/subscribeGroup/update',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
      data: data,
    );
    return ResponseEntity.fromJson(response);
  }

  /// 修改分组信息 //////////////////////////////////////////////////////////////
  static Future<ResponseEntity> create(data) async {
    var response = await HttpUtil().postForm(
      '/api/subscribeGroup/create',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
      data: data,
    );
    return ResponseEntity.fromJson(response);
  }
}
