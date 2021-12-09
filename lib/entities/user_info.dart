import 'dart:convert';

class UserInfo {
  UserInfo({
    /// 头像
    required this.avatar,

    /// 银行卡
    required this.banks,

    /// 个人主页背景
    required this.bannerPic,

    /// 生日
    required this.birthday,

    /// 屏蔽列表
    required this.blockCount,

    /// 注册日期
    required this.createDate,

    /// 钻石账户
    required this.diamondBalance,

    /// 数字货币
    required this.digitalCurrency,

    /// 邮箱
    required this.email,

    /// 订阅者
    required this.fansCount,

    /// 订阅的用户
    required this.followCount,

    /// 订阅组
    required this.groupName,

    /// 隐藏列表
    required this.hiddenCount,

    /// 个人简介
    required this.intro,

    /// 是否订阅
    required this.isSubscribe,

    /// 昵称
    required this.nickName,

    /// P币账户
    required this.pCoinBalance,

    /// 手机
    required this.phone,

    /// 订阅的群聊
    required this.subChatCount,

    /// 用户ID
    required this.userId,

    /// 用户名
    required this.userName,

    /// 水印开关
    required this.watermarkSwitch,

    /// 水印文字
    required this.watermarkText,
  });

  String avatar;
  List<Bank> banks;
  String bannerPic;
  int birthday;
  int blockCount;
  int createDate;
  int diamondBalance;
  DigitalCurrency digitalCurrency;
  String email;
  int fansCount;
  int followCount;
  String groupName;
  int hiddenCount;
  String intro;
  int isSubscribe;
  String nickName;
  int pCoinBalance;
  String phone;
  int subChatCount;
  int userId;
  String userName;
  int watermarkSwitch;
  String watermarkText;

  factory UserInfo.fromRawJson(String str) =>
      UserInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        avatar: json["avatar"],
        banks: List<Bank>.from(json["banks"].map((x) => Bank.fromJson(x))),
        bannerPic: json["bannerPic"],
        birthday: json["birthday"],
        blockCount: json["blockCount"],
        createDate: json["createDate"],
        diamondBalance: json["diamondBalance"],
        digitalCurrency: DigitalCurrency.fromJson(json["digitalCurrency"]),
        email: json["email"],
        fansCount: json["fansCount"],
        followCount: json["followCount"],
        groupName: json["groupName"],
        hiddenCount: json["hiddenCount"],
        intro: json["intro"],
        isSubscribe: json["isSubscribe"],
        nickName: json["nickName"],
        pCoinBalance: json["pCoinBalance"],
        phone: json["phone"],
        subChatCount: json["subChatCount"],
        userId: json["userId"],
        userName: json["userName"],
        watermarkSwitch: json["watermarkSwitch"],
        watermarkText: json["watermarkText"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "banks": List<dynamic>.from(banks.map((x) => x.toJson())),
        "bannerPic": bannerPic,
        "birthday": birthday,
        "blockCount": blockCount,
        "createDate": createDate,
        "diamondBalance": diamondBalance,
        "digitalCurrency": digitalCurrency.toJson(),
        "email": email,
        "fansCount": fansCount,
        "followCount": followCount,
        "groupName": groupName,
        "hiddenCount": hiddenCount,
        "intro": intro,
        "isSubscribe": isSubscribe,
        "nickName": nickName,
        "pCoinBalance": pCoinBalance,
        "phone": phone,
        "subChatCount": subChatCount,
        "userId": userId,
        "userName": userName,
        "watermarkSwitch": watermarkSwitch,
        "watermarkText": watermarkText,
      };
}

class Bank {
  Bank({
    required this.id,
    required this.name,
    required this.cardNumber,
    required this.bankCode,
    required this.bankName,
  });

  int id;
  String name;
  String cardNumber;
  String bankCode;
  String bankName;

  factory Bank.fromRawJson(String str) => Bank.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        id: json["id"],
        name: json["name"],
        cardNumber: json["cardNumber"],
        bankCode: json["bankCode"],
        bankName: json["bankName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cardNumber": cardNumber,
        "bankCode": bankCode,
        "bankName": bankName,
      };
}

class DigitalCurrency {
  DigitalCurrency({
    required this.btcBalance,
    required this.ethBalance,
    required this.usdtBalance,
  });

  int btcBalance;
  int ethBalance;
  int usdtBalance;

  factory DigitalCurrency.fromRawJson(String str) =>
      DigitalCurrency.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DigitalCurrency.fromJson(Map<String, dynamic> json) =>
      DigitalCurrency(
        btcBalance: json["btcBalance"],
        ethBalance: json["ethBalance"],
        usdtBalance: json["usdtBalance"],
      );

  Map<String, dynamic> toJson() => {
        "btcBalance": btcBalance,
        "ethBalance": ethBalance,
        "usdtBalance": usdtBalance,
      };
}
