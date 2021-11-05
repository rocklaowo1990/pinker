import 'dart:convert';

class UserInfo {
  UserInfo({
    /// 头像
    this.avatar,

    /// 银行卡
    this.banks,

    /// 个人主页背景
    this.bannerPic,

    /// 生日
    this.birthday,

    /// 屏蔽列表
    this.blockCount,

    /// 注册日期
    this.createDate,

    /// 钻石账户
    this.diamondBalance,

    /// 数字货币
    this.digitalCurrency,

    /// 邮箱
    this.email,

    /// 订阅者
    this.fansCount,

    /// 订阅的用户
    this.followCount,

    /// 订阅组
    this.groupName,

    /// 隐藏列表
    this.hiddenCount,

    /// 个人简介
    this.intro,

    /// 是否订阅
    this.isSubscribe,

    /// 昵称
    this.nickName,

    /// P币账户
    this.pCoinBalance,

    /// 手机
    this.phone,

    /// 订阅的群聊
    this.subChatCount,

    /// 用户ID
    this.userId,

    /// 用户名
    this.userName,

    /// 水印开关
    this.watermarkSwitch,

    /// 水印文字
    this.watermarkText,
  });

  String? avatar;
  List<Bank>? banks;
  String? bannerPic;
  int? birthday;
  int? blockCount;
  int? createDate;
  int? diamondBalance;
  DigitalCurrency? digitalCurrency;
  String? email;
  int? fansCount;
  int? followCount;
  String? groupName;
  int? hiddenCount;
  String? intro;
  int? isSubscribe;
  String? nickName;
  int? pCoinBalance;
  String? phone;
  int? subChatCount;
  int? userId;
  String? userName;
  int? watermarkSwitch;
  String? watermarkText;

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
        "banks": banks == null || banks == []
            ? null
            : List<dynamic>.from(banks!.map((x) => x.toJson())),
        "bannerPic": bannerPic,
        "birthday": birthday,
        "blockCount": blockCount,
        "createDate": createDate,
        "diamondBalance": diamondBalance,
        "digitalCurrency":
            digitalCurrency == null ? null : digitalCurrency!.toJson(),
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
    this.id,
    this.name,
    this.cardNumber,
    this.bankCode,
    this.bankName,
  });

  int? id;
  String? name;
  String? cardNumber;
  String? bankCode;
  String? bankName;

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
    this.btcBalance,
    this.ethBalance,
    this.usdtBalance,
  });

  int? btcBalance;
  int? ethBalance;
  int? usdtBalance;

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
