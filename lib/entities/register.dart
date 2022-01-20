// 找回密码时的数据格式化
class RegisterEntities {
  RegisterEntities({
    required this.account,
    required this.accountType,
    required this.birthday,
    required this.code,
    required this.password,
    this.inviteCode,
    required this.areaCode,
    this.pushId,
  });

  String account;
  int accountType;
  int birthday;
  String code;
  String password;
  String? inviteCode;
  String areaCode;
  int? pushId;

  factory RegisterEntities.fromJson(Map<String, dynamic> json) =>
      RegisterEntities(
        account: json["account"],
        accountType: json["accountType"],
        birthday: json["birthday"],
        code: json["code"],
        password: json["password"],
        inviteCode: json["inviteCode"],
        areaCode: json["areaCode"],
        pushId: json["pushId"],
      );

  Map<String, dynamic> toJson() => {
        'account': account,
        'accountType': accountType,
        'birthday': birthday,
        'code': code,
        'password': password,
        'inviteCode': inviteCode,
        'areaCode': areaCode,
        'pushId': pushId,
      };

  static Map<String, dynamic> child = {
    'account': '',
    'accountType': 0,
    'birthday': 0,
    'code': '',
    'password': '',
    'inviteCode': '',
    'areaCode': '',
    'pushId': 0,
  };
}
