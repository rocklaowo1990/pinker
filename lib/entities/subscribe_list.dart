class SubscribeListEntities {
  SubscribeListEntities({
    required this.list,
    required this.totalSize,
  });

  List<_List> list;
  int totalSize;

  factory SubscribeListEntities.fromJson(Map<String, dynamic> json) =>
      SubscribeListEntities(
        list: List<_List>.from(json["list"].map((x) => _List.fromJson(x))),
        totalSize: json["totalSize"],
      );

  Map<String, dynamic> toJson() => {
        "list": List<_List>.from(list.map((x) => x.toJson())),
        "totalSize": totalSize,
      };
  static Map<String, dynamic> child = {
    "list": <_List>[],
    "totalSize": 0,
  };
}

class _List {
  _List({
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
  int groupId;
  String intro;
  String avatar;
  String nickName;
  String userName;
  String groupName;
  int amount;
  int isAutoRenewal;
  int memberCount;

  factory _List.fromJson(Map<String, dynamic> json) => _List(
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
