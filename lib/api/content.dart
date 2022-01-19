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
  static Future contentList({
    required int pageNo,
    required int type,
    String? keywords,
  }) async {
    var response = await HttpUtil().get(
      '/api/content/contentList',
      queryParameters: {
        'pageNo': pageNo,
        'pageSize': 20,
        'type': type,
        'keywords': keywords,
      },
      options: Options(headers: {
        'token': Global.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 个人的作品列表
  static Future userHomeContentList({
    int? pageNo,
    required int type,
    int? userId,
  }) async {
    var response = await HttpUtil().get(
      '/api/content/userHomeContentList',
      queryParameters: {
        'pageNo': pageNo,
        'pageSize': 20,
        'type': type,
        'userId': userId,
      },
      options: Options(headers: {
        'token': Global.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 作品详情
  ///
  static Future contentDetail({required int wid}) async {
    var response = await HttpUtil().get(
      '/api/content/contentDetail',
      queryParameters: {'wid': wid},
      options: Options(headers: {
        'token': Global.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 作品列表：首页 /////////////////////////////////////////////////
  static Future homeContentList({required int pageNo}) async {
    var response = await HttpUtil().get(
      '/api/content/homeContentList',
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
  static Future commentsAdd(
      {required int wid,
      int? cid,
      required String content,
      int? beUserId}) async {
    var response = await HttpUtil().postForm(
      '/api/content/commentsAdd',
      data: {
        'wid': wid,
        'cid': cid,
        'content': content,
        'beUserId': beUserId,
      },
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
  static Future like({
    required int wid,
    int? cid,
    required int type,
    required int isLike,
  }) async {
    var response = await HttpUtil().postForm(
      '/api/content/like',
      data: {
        'wid': wid,
        'cid': cid,
        'type': type,
        'isLike': isLike,
      },
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
  static Future forward({
    required int wid,
    required int isForward,
  }) async {
    var response = await HttpUtil().postForm(
      '/api/content/forward',
      data: {
        'wid': wid,
        'isForward': isForward,
      },
      options: Options(headers: {
        'token': Global.token,
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 支付作品
  static Future payment({
    required int wid,
    int? type,
  }) async {
    var response = await HttpUtil().postForm(
      '/api/content/payment',
      data: {
        'wid': wid,
        if (type != null) 'type': type,
      },
      options: Options(headers: {
        'token': Global.token,
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
    );
    return ResponseEntity.fromJson(response);
  }
}
