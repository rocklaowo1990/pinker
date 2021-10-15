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
    this.token,
    this.msg,
  });

  int? code;
  String? token;
  String? msg;

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseEntity(
        code: json["code"],
        token: json["data"] == '' ? null : json["data"]['token'],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "token": token,
        "msg": msg,
      };
}
