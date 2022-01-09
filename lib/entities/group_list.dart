class GroupListEntities {
  GroupListEntities({
    required this.list,
    required this.totalSize,
    required this.balance,
    required this.user,
  });

  List<GroupInfoEntities> list;
  int totalSize;
  String balance;
  _User user;

  factory GroupListEntities.fromJson(Map<String, dynamic> json) =>
      GroupListEntities(
        list: List<GroupInfoEntities>.from(
            json["list"].map((x) => GroupInfoEntities.fromJson(x))),
        totalSize: json["totalSize"],
        balance: json["balance"],
        user: _User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "totalSize": totalSize,
        "balance": balance,
        "user": user.toJson(),
      };
}

class GroupInfoEntities {
  GroupInfoEntities({
    required this.groupId,
    required this.groupName,
    required this.groupPic,
    required this.amount,
    required this.createDate,
    required this.memberCount,
  });

  int groupId;
  String groupName;
  String groupPic;
  double amount;
  int createDate;
  int memberCount;

  factory GroupInfoEntities.fromJson(Map<String, dynamic> json) =>
      GroupInfoEntities(
        groupId: json["groupId"],
        groupName: json["groupName"],
        groupPic: json["groupPic"],
        amount: json["amount"].toDouble(),
        createDate: json["createDate"],
        memberCount: json["memberCount"],
      );

  Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "groupName": groupName,
        "groupPic": groupPic,
        "amount": amount,
        "createDate": createDate,
        "memberCount": memberCount,
      };
}

class _User {
  _User({
    required this.userId,
    required this.nickName,
    required this.avatar,
    required this.userName,
  });

  int userId;
  String nickName;
  String avatar;
  String userName;

  factory _User.fromJson(Map<String, dynamic> json) => _User(
        userId: json["userId"],
        nickName: json["nickName"],
        avatar: json["avatar"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "nickName": nickName,
        "avatar": avatar,
        "userName": userName,
      };
}
