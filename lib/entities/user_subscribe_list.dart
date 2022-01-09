class UserSubscribeEntities {
  UserSubscribeEntities({
    required this.userId,
    required this.endDate,
    required this.groupId,
    required this.intro,
    required this.avatar,
    required this.nickName,
    required this.userName,
    required this.groupName,
    required this.amount,
    required this.isAutoRenewal,
    required this.memberCount,
  });

  int userId;
  int endDate;
  String groupId;
  String intro;
  String avatar;
  String nickName;
  String userName;
  String groupName;
  String amount;
  int isAutoRenewal;
  int memberCount;

  factory UserSubscribeEntities.fromJson(Map<String, dynamic> json) =>
      UserSubscribeEntities(
        userId: json["userId"],
        endDate: json["endDate"],
        groupId: json["groupId"],
        intro: json["intro"],
        avatar: json["avatar"],
        nickName: json["nickName"],
        userName: json["userName"],
        groupName: json["groupName"],
        amount: json["amount"],
        isAutoRenewal: json["isAutoRenewal"],
        memberCount: json["memberCount"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "endDate": endDate,
        "groupId": groupId,
        "intro": intro,
        "avatar": avatar,
        "nickName": nickName,
        "userName": userName,
        "groupName": groupName,
        "amount": amount,
        "isAutoRenewal": isAutoRenewal,
        "memberCount": memberCount,
      };
}
