import 'package:dio/dio.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/global.dart';
import 'package:pinker/utils/utils.dart';

class HomeApi {
  /// 活动列表
  static Future activityList({
    required int pageNo,
  }) async {
    var response = await HttpUtil().get(
      '/api/home/activityList',
      queryParameters: {
        'pageNo': pageNo,
        'pageSize': 20,
      },
      options: Options(headers: {
        'token': Global.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 首页轮播图和金刚区
  static Future config() async {
    var response = await HttpUtil().get(
      '/api/home/config',
      options: Options(headers: {
        'token': Global.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }
}
