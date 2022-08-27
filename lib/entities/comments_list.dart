class CommentsListEntities {
  CommentsListEntities({
    required this.list,
    required this.totalSize,
  });

  List<_ListElement> list;
  int totalSize;

  factory CommentsListEntities.fromJson(Map<String, dynamic> json) =>
      CommentsListEntities(
        list: List<_ListElement>.from(
            json["list"].map((x) => _ListElement.fromJson(x))),
        totalSize: json["totalSize"],
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "totalSize": totalSize,
      };

  static Map<String, dynamic> child = {
    "list": <_ListElement>[],
    "totalSize": 0,
  };
}

class _ListElement {
  _ListElement({
    required this.cid,
    required this.author,
    required this.createDate,
    required this.content,
    required this.commentCount,
    required this.likeCount,
    required this.isLike,
    this.replyUser,
  });

  String cid;
  _Author author;
  int createDate;
  String content;
  int commentCount;
  int likeCount;
  int isLike;
  _Author? replyUser;

  factory _ListElement.fromJson(Map<String, dynamic> json) => _ListElement(
        cid: json["cid"],
        author: _Author.fromJson(json["author"]),
        createDate: json["createDate"],
        content: json["content"],
        commentCount: json["commentCount"],
        likeCount: json["likeCount"],
        isLike: json["isLike"],
        replyUser: json["replyUser"] == null || json["replyUser"] == []
            ? null
            : _Author.fromJson(json["replyUser"]),
      );

  Map<String, dynamic> toJson() => {
        "cid": cid,
        "author": author.toJson(),
        "createDate": createDate,
        "content": content,
        "commentCount": commentCount,
        "likeCount": likeCount,
        "isLike": isLike,
        "replyUser": replyUser == null ? null : replyUser!.toJson(),
      };
}

class _Author {
  _Author({
    required this.userId,
    required this.avatar,
    required this.nickName,
    required this.userName,
    required this.intro,
  });

  int userId;
  String avatar;
  String nickName;
  String userName;
  String intro;

  factory _Author.fromJson(Map<String, dynamic> json) => _Author(
        userId: json["userId"] ?? json["userid"],
        avatar: json["avatar"],
        nickName: json["nickName"],
        userName: json["userName"],
        intro: json["intro"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "avatar": avatar,
        "nickName": nickName,
        "userName": userName,
        "intro": intro,
      };
}
