// 登录请求
class UserLoginRequestEntity {
  String email;
  String password;

  UserLoginRequestEntity({
    required this.email,
    required this.password,
  });

  factory UserLoginRequestEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginRequestEntity(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

// 登录返回
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
        data: json['data'],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "token": data,
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
