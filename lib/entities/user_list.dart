class UserListEntities {
  UserListEntities({
    required this.list,
    required this.totalSize,
  });

  List<_UerInfo> list;
  int totalSize;

  factory UserListEntities.fromJson(Map<String, dynamic> json) =>
      UserListEntities(
        list:
            List<_UerInfo>.from(json["list"].map((x) => _UerInfo.fromJson(x))),
        totalSize: json["totalSize"],
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "totalSize": totalSize,
      };

  static Map<String, dynamic> child = {
    "list": <_UerInfo>[],
    "totalSize": 0,
  };
}

class _UerInfo {
  _UerInfo({
    required this.userId,
    required this.nickName,
    required this.avatar,
    required this.intro,
    required this.isSubscribe,
    required this.userName,
    required this.groupCount,
    this.subedGroupId,
    this.subedGroupName,
    this.groupPic,
    this.freeGroupId,
    this.freeGroupName,
  });

  int userId;
  String nickName;
  String avatar;
  String intro;
  int isSubscribe;
  String userName;
  int groupCount;
  int? subedGroupId;
  String? subedGroupName;
  String? groupPic;
  int? freeGroupId;
  String? freeGroupName;

  factory _UerInfo.fromJson(Map<String, dynamic> json) => _UerInfo(
        userId: json["userId"],
        nickName: json["nickName"],
        avatar: json["avatar"],
        intro: json["intro"],
        isSubscribe: json["isSubscribe"],
        userName: json["userName"],
        groupCount: json["groupCount"],
        subedGroupId: json["subedGroupId"],
        subedGroupName: json["subedGroupName"],
        groupPic: json["groupPic"],
        freeGroupId: json["freeGroupId"],
        freeGroupName: json["freeGroupName"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "nickName": nickName,
        "avatar": avatar,
        "intro": intro,
        "isSubscribe": isSubscribe,
        "userName": userName,
        "groupCount": groupCount,
        "subedGroupId": subedGroupId,
        "subedGroupName": subedGroupName,
        "groupPic": groupPic,
        "freeGroupId": freeGroupId,
        "freeGroupName": freeGroupName,
      };
}
