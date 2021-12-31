// 找回密码时的数据格式化
class ForgotInfoEntities {
  ForgotInfoEntities({
    required this.userId,
    required this.userName,
    required this.nickName,
    required this.avatar,
    required this.phone,
    required this.email,
  });

  int userId;
  String userName;
  String nickName;
  String avatar;
  String phone;
  String email;

  factory ForgotInfoEntities.fromJson(Map<String, dynamic> json) =>
      ForgotInfoEntities(
        userId: json["userId"],
        userName: json["userName"],
        nickName: json["nickName"],
        avatar: json["avatar"],
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'userName': userName,
        'nickName': nickName,
        'avatar': avatar,
        'phone': phone,
        'email': email,
      };

  static Map<String, dynamic> child = {
    'userId': 0,
    'userName': '',
    'nickName': '',
    'avatar': '',
    'phone': '',
    'email': '',
  };
}
