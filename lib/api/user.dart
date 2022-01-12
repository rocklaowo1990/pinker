import 'package:dio/dio.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/global.dart';

import 'package:pinker/utils/utils.dart';

class UserApi {
  /// 用户列表
  static Future<ResponseEntity> list({
    int? pageNo,
    required int type,
    int? wid,
    int? userId,
    int? cid,
    String? keywords,
  }) async {
    // 请求
    var response = await HttpUtil().get(
      '/api/user/list',
      queryParameters: {
        'pageNo': pageNo,
        'pageSize': 20,
        'type': type,
        'wid': wid,
        'userId': userId,
        'cid': cid,
        'keywords': keywords,
      },
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
    );

    return ResponseEntity.fromJson(response);
  }

  /// 更新用户信息 ///////////////////////////////////////////////////////////////
  static Future<ResponseEntity> updateUserInfo({
    String? avatar,
    String? bannerPic,
    String? nickName,
    int? birthday,
    String? intro,
    String? watermarkSwitch,
    String? watermarkText,
    String? pushId,
  }) async {
    // 请求
    var response = await HttpUtil().postForm(
      '/api/user/updateUserInfo',
      data: {
        if (avatar != null) 'avatar': avatar,
        if (bannerPic != null) 'bannerPic': bannerPic,
        if (nickName != null) 'nickName': nickName,
        if (birthday != null) 'birthday': birthday,
        if (intro != null) 'intro': intro,
        if (watermarkSwitch != null) 'watermarkSwitch': watermarkSwitch,
        if (watermarkText != null) 'watermarkText': watermarkText,
        if (pushId != null) 'pushId': pushId,
      },
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

  /// 重置密码
  static Future<ResponseEntity> resetPassword({
    required int userId,
    required String code,
    required String newPassword,
    required int type,
    int? pushId,
  }) async {
    // 请求
    var response = await HttpUtil().postForm(
      '/api/user/resetPassword',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
      data: {
        'userId': userId,
        'code': code,
        'newPassword': newPassword,
        'type': type,
        if (pushId != null) 'pushId': pushId,
      },
    );

    return ResponseEntity.fromJson(response);
  }

  /// 设置用户名 ////////////////////////////////////////////////////////////////
  static Future<ResponseEntity> setUserName({
    required String userName,
  }) async {
    // 请求
    var response = await HttpUtil().postForm(
      '/api/user/setUserName',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
      data: {
        'userName': userName,
      },
    );

    return ResponseEntity.fromJson(response);
  }

  /// 设置手机号码 //////////////////////////////////////////////////////////////
  static Future<ResponseEntity> setMobile({
    required String password,
    required String code,
    required String mobile,
    required String areaCode,
  }) async {
    // 请求
    var response = await HttpUtil().postForm(
      '/api/user/setMobile',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
      data: {
        'password': password,
        'code': code,
        'mobile': mobile,
        'areaCode': areaCode,
      },
    );

    return ResponseEntity.fromJson(response);
  }

  /// 设置邮箱地址 //////////////////////////////////////////////////////////////
  static Future<ResponseEntity> setEmail({
    required String password,
    required String code,
    required String email,
  }) async {
    // 请求
    var response = await HttpUtil().postForm(
      '/api/user/setEmail',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
      data: {
        'password': password,
        'code': code,
        'email': email,
      },
    );
    return ResponseEntity.fromJson(response);
  }

  /// 修改密码
  ///
  /// type：1-密码方式 2验证码方式）
  ///
  static Future<ResponseEntity> setPassword({
    String? oldPassword,
    required String newPassword,
    required int type,
    String? code,
  }) async {
    // 请求
    var response = await HttpUtil().postForm(
      '/api/user/setPassword',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
      data: {
        if (oldPassword != null) 'oldPassword': oldPassword,
        'newPassword': newPassword,
        'type': type,
        if (code != null) 'code': code,
      },
    );
    return ResponseEntity.fromJson(response);
  }

  /// 已屏蔽的用户列表
  ///
  /// 屏蔽列表地址：'/api/user/blockUserList'
  ///
  /// 隐藏列表地址：'/api/user/hideUserList'
  ///
  /// 'pageNo':当前请求的页码
  ///
  /// 目前固定一页请求20条数据
  ///
  static Future<ResponseEntity> getCountList(
    String apiUrl, {
    required int pageNo,
  }) async {
    // 请求
    var response = await HttpUtil().get(
      apiUrl,
      options: Options(headers: {
        'token': Global.token,
      }),
      queryParameters: {
        'pageNo': pageNo,
        'pageSize': 20,
      },
    );
    return ResponseEntity.fromJson(response);
  }

  /// 屏蔽用户/ 隐藏用户 /////////////////////
  /// 这里是操作屏蔽和隐藏
  /// 隐藏：'/api/user/hide'
  /// 屏蔽：'/api/user/block'
  /// data：这里直接放到一起，通过不同的参数去区分
  static Future<ResponseEntity> blockHide(
    String apiUrl, {
    required int userId,
    required String dataType,
    required int dataNumber,
  }) async {
    // 请求
    var response = await HttpUtil().postForm(
      apiUrl,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
      data: {
        'userId': userId,
        dataType: dataNumber,
      },
    );
    return ResponseEntity.fromJson(response);
  }

  /// 单独的隐藏用户接口
  ///
  /// dataNumber :  1-隐藏用户；0-取消隐藏用户
  static Future<ResponseEntity> hide({
    required int userId,
    required int isHide,
  }) async {
    // 请求
    var response = await HttpUtil().postForm(
      '/api/user/hide',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
      data: {
        'userId': userId,
        'isHide': isHide,
      },
    );
    return ResponseEntity.fromJson(response);
  }

  /// 单独的屏蔽用户接口
  ///
  /// dataNumber :  1-屏蔽户；0-取消屏蔽用户
  static Future<ResponseEntity> block({
    required int userId,
    required int isBlock,
  }) async {
    // 请求
    var response = await HttpUtil().postForm(
      '/api/user/block',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
      data: {
        'userId': userId,
        'isBlock': isBlock,
      },
    );
    return ResponseEntity.fromJson(response);
  }

  /// 获取水印设计
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

  /// 水印设置
  ///
  /// 'enable': 1 开启 0关闭
  ///
  /// 'text': 水印文字
  ///
  static Future<ResponseEntity> setUserLogo({
    required int enable,
    String? text,
  }) async {
    // 请求
    var response = await HttpUtil().postForm(
      '/api/user/setUserLogo',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
      data: {
        'enable': enable,
        'text': text,
      },
    );
    return ResponseEntity.fromJson(response);
  }

  /// 查看针对某个用户的订阅信息
  ///
  /// 这里是操作屏蔽和隐藏
  ///
  /// 'userId':被查看的用户ID
  static Future<ResponseEntity> oneSubscribeInfo({
    required int userId,
  }) async {
    var response = await HttpUtil().get(
      '/api/user/oneSubscribeInfo',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
      queryParameters: {
        'userId': userId,
      },
    );
    return ResponseEntity.fromJson(response);
  }

  /// 订阅用户组
  ///
  /// 'groupId':订阅组ID
  ///
  /// 'userId':被订阅的用户ID
  static Future<ResponseEntity> subscribeGroup({
    required int userId,
    required int groupId,
  }) async {
    var response = await HttpUtil().postForm(
      '/api/user/subscribeGroup',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
      data: {
        'userId': userId,
        'groupId': groupId,
      },
    );
    return ResponseEntity.fromJson(response);
  }

  /// 查看我的订阅列表
  static Future<ResponseEntity> subscribeList({
    required int pageNo,
  }) async {
    var response = await HttpUtil().get(
      '/api/user/subscribeList',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': Global.token,
      }),
      queryParameters: {
        'pageNo': pageNo,
        'pageSize': 20,
      },
    );
    return ResponseEntity.fromJson(response);
  }
}
