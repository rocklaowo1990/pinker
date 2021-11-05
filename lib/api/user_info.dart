import 'dart:convert';

class UserInfo {
  UserInfo({
    required this.avatar,
    required this.banks,
    required this.bannerPic,
    required this.birthday,
    required this.blockCount,
    required this.createDate,
    required this.diamondBalance,
    required this.digitalCurrency,
    required this.email,
    required this.fansCount,
    required this.followCount,
    required this.groupName,
    required this.hiddenCount,
    required this.intro,
    required this.isSubscribe,
    required this.nickName,
    required this.pCoinBalance,
    required this.phone,
    required this.subChatCount,
    required this.userId,
    required this.userName,
    required this.watermarkSwitch,
    required this.watermarkText,
  });

  String avatar;
  List<Bank> banks;
  String bannerPic;
  int birthday;
  int blockCount;
  String createDate;
  String diamondBalance;
  DigitalCurrency digitalCurrency;
  String email;
  int fansCount;
  int followCount;
  String groupName;
  int hiddenCount;
  String intro;
  int isSubscribe;
  String nickName;
  String pCoinBalance;
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

  String btcBalance;
  String ethBalance;
  String usdtBalance;

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
