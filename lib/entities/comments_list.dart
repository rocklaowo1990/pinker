class CommentsListEntities {
  CommentsListEntities({
    required this.list,
    required this.totalSize,
  });

  List<ListElementComments> list;
  int totalSize;

  factory CommentsListEntities.fromJson(Map<String, dynamic> json) =>
      CommentsListEntities(
        list: List<ListElementComments>.from(
            json["list"].map((x) => ListElementComments.fromJson(x))),
        totalSize: json["totalSize"],
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "totalSize": totalSize,
      };
}

class ListElementComments {
  ListElementComments({
    required this.cid,
    required this.author,
    required this.createDate,
    required this.content,
    required this.commentCount,
    required this.likeCount,
    required this.isLike,
    this.replyUser,
  });

  int cid;
  Author author;
  int createDate;
  String content;
  int commentCount;
  int likeCount;
  int isLike;
  Author? replyUser;

  factory ListElementComments.fromJson(Map<String, dynamic> json) =>
      ListElementComments(
        cid: json["cid"],
        author: Author.fromJson(json["author"]),
        createDate: json["createDate"],
        content: json["content"],
        commentCount: json["commentCount"],
        likeCount: json["likeCount"],
        isLike: json["isLike"],
        replyUser: json["replyUser"] == null || json["replyUser"] == []
            ? null
            : Author.fromJson(json["replyUser"]),
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

class Author {
  Author({
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

  factory Author.fromJson(Map<String, dynamic> json) => Author(
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
