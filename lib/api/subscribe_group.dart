import 'package:dio/dio.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/global.dart';
import 'package:pinker/utils/utils.dart';

class SubscribeGroupApi {
  /// 分组列表 /////////////////////////////////////////////////////////////////
  static Future<ResponseEntity> list({
    required int pageNo,
    int? userId,
  }) async {
    var response = await HttpUtil().get(
      '/api/subscribeGroup/list',
      options: Options(headers: {
        'token': Global.token,
      }),
      queryParameters: {
        'pageNo': pageNo,
        'pageSize': 20,
        'userId': userId,
      },
    );
    return ResponseEntity.fromJson(response);
  }

  /// 修改分组信息 //////////////////////////////////////////////////////////////
  static Future<ResponseEntity> update({
    required int groupId,
    required String groupName,
    required String groupPic,
    required double amount,
  }) async {
    var response = await HttpUtil().postForm(
      '/api/subscribeGroup/update',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
      data: {
        'groupId': groupId,
        'groupName': groupName,
        'groupPic': groupPic,
        'amount': amount,
        'timeLen': 30,
      },
    );
    return ResponseEntity.fromJson(response);
  }

  /// 修改分组信息 //////////////////////////////////////////////////////////////
  static Future<ResponseEntity> create({
    required String groupName,
    required String groupPic,
    required String amount,
  }) async {
    var response = await HttpUtil().postForm(
      '/api/subscribeGroup/create',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
      data: {
        'groupName': groupName,
        'groupPic': groupPic,
        'amount': amount,
        'timeLen': 30,
      },
    );
    return ResponseEntity.fromJson(response);
  }
}
