import 'package:dio/dio.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/global.dart';
import 'package:pinker/utils/utils.dart';

class ContentApi {
  /// 作品列表 /////////////////////////////////////////////////
  static Future contentList(data) async {
    var response = await HttpUtil().get(
      '/api/content/contentList',
      queryParameters: data,
      options: Options(headers: {
        'token': Global.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 作品列表：首页 /////////////////////////////////////////////////
  static Future homeContentList(data) async {
    var response = await HttpUtil().get(
      '/api/content/homeContentList',
      queryParameters: data,
      options: Options(headers: {
        'token': Global.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }
}
