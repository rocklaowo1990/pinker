class UserInfoEntities {
  UserInfoEntities({
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
  List<_Bank> banks;
  String bannerPic;
  int birthday;
  int blockCount;
  int createDate;
  String diamondBalance;
  _DigitalCurrency digitalCurrency;
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

  factory UserInfoEntities.fromJson(Map<String, dynamic> json) =>
      UserInfoEntities(
        avatar: json["avatar"],
        banks: List<_Bank>.from(json["banks"].map((x) => _Bank.fromJson(x))),
        bannerPic: json["bannerPic"],
        birthday: json["birthday"],
        blockCount: json["blockCount"],
        createDate: json["createDate"],
        diamondBalance: json["diamondBalance"],
        digitalCurrency: _DigitalCurrency.fromJson(json["digitalCurrency"]),
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

  static Map<String, dynamic> child = {
    "avatar": '',
    "banks": [
      {
        "id": 0,
        "name": '',
        "cardNumber": '',
        "bankCode": '',
        "bankName": '',
      }
    ],
    "bannerPic": '',
    "birthday": 0,
    "blockCount": 0,
    "createDate": 0,
    "diamondBalance": '0.00',
    "digitalCurrency": {
      "btcBalance": 0,
      "ethBalance": 0,
      "usdtBalance": 0,
    },
    "email": '',
    "fansCount": 0,
    "followCount": 0,
    "groupName": '',
    "hiddenCount": 0,
    "intro": '',
    "isSubscribe": 0,
    "nickName": '',
    "pCoinBalance": '0.00',
    "phone": '',
    "subChatCount": 0,
    "userId": 0,
    "userName": '',
    "watermarkSwitch": 0,
    "watermarkText": '',
  };
}

class _Bank {
  _Bank({
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

  factory _Bank.fromJson(Map<String, dynamic> json) => _Bank(
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

class _DigitalCurrency {
  _DigitalCurrency({
    required this.btcBalance,
    required this.ethBalance,
    required this.usdtBalance,
  });

  int btcBalance;
  int ethBalance;
  int usdtBalance;

  factory _DigitalCurrency.fromJson(Map<String, dynamic> json) =>
      _DigitalCurrency(
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
