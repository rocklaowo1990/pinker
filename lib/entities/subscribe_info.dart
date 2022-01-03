class SubscribeInfoEntities {
  SubscribeInfoEntities({
    required this.groups,
    this.subGroupList,
    required this.balance,
  });

  final List<_Group> groups;
  final _SubGroupList? subGroupList;
  final double balance;

  factory SubscribeInfoEntities.fromJson(Map<String, dynamic> json) =>
      SubscribeInfoEntities(
        groups:
            List<_Group>.from(json["groups"].map((x) => _Group.fromJson(x))),
        subGroupList: json["subGroupList"] == null
            ? null
            : _SubGroupList.fromJson(json["subGroupList"]),
        balance: json["balance"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "groups": List<dynamic>.from(groups.map((x) => x.toJson())),
        "subGroupList": subGroupList == null ? null : subGroupList!.toJson(),
        "balance": balance,
      };
  static Map<String, dynamic> child = {
    "groups": [
      {
        "groupId": 0,
        "amount": 0.0,
        "groupName": '',
        "timeLen": 0,
        "groupPic": '',
      }
    ],
    "subGroupList": {
      "groupId": 0,
      "groupName": '',
      "endDate": 0,
      "nickName": '',
      "avatar": '',
      "userName": '',
      "groupPic": '',
    },
    "balance": 0.0,
  };
}

class _Group {
  _Group({
    required this.groupId,
    required this.amount,
    required this.groupName,
    required this.timeLen,
    required this.groupPic,
  });

  final int groupId;
  final double amount;
  final String groupName;
  final int timeLen;
  final String groupPic;

  factory _Group.fromJson(Map<String, dynamic> json) => _Group(
        groupId: json["groupId"],
        amount: json["amount"].toDouble(),
        groupName: json["groupName"],
        timeLen: json["timeLen"],
        groupPic: json["groupPic"],
      );

  Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "amount": amount,
        "groupName": groupName,
        "timeLen": timeLen,
        "groupPic": groupPic,
      };
}

class _SubGroupList {
  _SubGroupList({
    required this.groupId,
    required this.groupName,
    required this.endDate,
    required this.nickName,
    required this.avatar,
    required this.userName,
    required this.groupPic,
  });

  final int groupId;
  final String groupName;
  final int endDate;
  final String nickName;
  final String avatar;
  final String userName;
  final String groupPic;

  factory _SubGroupList.fromJson(Map<String, dynamic> json) => _SubGroupList(
        groupId: json["groupId"],
        groupName: json["groupName"],
        endDate: json["endDate"],
        nickName: json["nickName"],
        avatar: json["avatar"],
        userName: json["userName"],
        groupPic: json["groupPic"],
      );

  Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "groupName": groupName,
        "endDate": endDate,
        "nickName": nickName,
        "avatar": avatar,
        "userName": userName,
        "groupPic": groupPic,
      };
}
