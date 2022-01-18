class PersonalEntities {
  PersonalEntities({
    required this.userId,
    required this.nickName,
    required this.avatar,
    required this.followCount,
    required this.fansCount,
    required this.intro,
    required this.createDate,
    required this.bannerPic,
    required this.birthday,
    required this.userName,
    required this.isSubscribe,
    required this.blockCount,
    required this.hiddenCount,
    this.groupName,
    this.groupPic,
    this.groupId,
  });

  int userId;
  String nickName;
  String avatar;
  int followCount;
  int fansCount;
  String intro;
  int createDate;
  String bannerPic;
  int birthday;
  String userName;
  int isSubscribe;
  int blockCount;
  int hiddenCount;
  String? groupName;
  String? groupPic;
  int? groupId;

  factory PersonalEntities.fromJson(Map<String, dynamic> json) =>
      PersonalEntities(
        userId: json["userId"],
        nickName: json["nickName"],
        avatar: json["avatar"],
        followCount: json["followCount"],
        fansCount: json["fansCount"],
        intro: json["intro"],
        createDate: json["createDate"],
        bannerPic: json["bannerPic"],
        birthday: json["birthday"],
        userName: json["userName"],
        isSubscribe: json["isSubscribe"],
        blockCount: json["blockCount"],
        hiddenCount: json["hiddenCount"],
        groupName: json["groupName"],
        groupPic: json["groupPic"],
        groupId: json["groupId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "nickName": nickName,
        "avatar": avatar,
        "followCount": followCount,
        "fansCount": fansCount,
        "intro": intro,
        "createDate": createDate,
        "bannerPic": bannerPic,
        "birthday": birthday,
        "userName": userName,
        "isSubscribe": isSubscribe,
        "blockCount": blockCount,
        "hiddenCount": hiddenCount,
        "groupName": groupName,
        "groupPic": groupPic,
        "groupId": groupId,
      };
  static Map<String, dynamic> child = {
    "userId": 0,
    "nickName": '',
    "avatar": '',
    "followCount": 0,
    "fansCount": 0,
    "intro": '',
    "createDate": 0,
    "bannerPic": '',
    "birthday": 0,
    "userName": '',
    "isSubscribe": 0,
    "blockCount": 0,
    "hiddenCount": 0,
  };
}
