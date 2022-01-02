import 'package:dio/dio.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/global.dart';
import 'package:pinker/utils/utils.dart';

class ContentApi {
  /// 作品列表
  ///
  /// type：1代表全部
  ///
  /// type：2代表最新
  ///
  /// type：3代表最热
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

  /// 评论列表
  ///
  /// 'wid':1
  ///
  /// 'pageNo':1
  ///
  /// 'pageSize':1
  static Future commentsList(data) async {
    var response = await HttpUtil().get(
      '/api/content/commentsList',
      queryParameters: data,
      options: Options(headers: {
        'token': Global.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 添加评论 /////////////////////////////////////////////////
  static Future commentsAdd(data) async {
    var response = await HttpUtil().postForm(
      '/api/content/commentsAdd',
      data: data,
      options: Options(headers: {
        'token': Global.token,
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 点赞/取消点赞
  ///
  /// 'wid': '作品ID',
  ///
  /// 'cid':'评论ID（否',
  ///
  /// 'type':'1作品 2评论',
  ///
  /// 'isLike':'1点赞  0取消点赞',
  static Future like(data) async {
    var response = await HttpUtil().postForm(
      '/api/content/like',
      data: data,
      options: Options(headers: {
        'token': Global.token,
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 点赞/取消点赞
  ///
  /// 'wid': '作品ID',
  ///
  /// 'isForward':'（1-转发；0-取消转发）',
  static Future forward(data) async {
    var response = await HttpUtil().postForm(
      '/api/content/forward',
      data: data,
      options: Options(headers: {
        'token': Global.token,
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
    );
    return ResponseEntity.fromJson(response);
  }
}
