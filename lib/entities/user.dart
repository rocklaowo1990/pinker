// 登录返回数据格式化
class UserLoginResponseEntity {
  UserLoginResponseEntity({
    this.code,
    this.data,
    this.msg,
  });

  int? code;
  Data? data;
  String? msg;

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseEntity(
        code: json["code"],
        data: json["data"] == '' || json['data'] == null
            ? null
            : Data.fromJson(json["data"]),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data == null ? null : data!.toJson(),
        "msg": msg,
      };
}

class Data {
  Data({
    this.token,
  });

  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
