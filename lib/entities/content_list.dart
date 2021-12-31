class ContentListEntities {
  ContentListEntities({
    required this.list,
    required this.totalSize,
  });

  List<_ListElement> list;
  int totalSize;

  factory ContentListEntities.fromJson(Map<String, dynamic> json) =>
      ContentListEntities(
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
    required this.wid,
    required this.createDate,
    required this.commentCount,
    required this.forwardCount,
    required this.likeCount,
    required this.shareCount,
    required this.isLike,
    required this.viewCount,
    required this.author,
    required this.works,
    required this.canSee,
    required this.isForward,
    required this.canReply,
    this.isTopMost,
    this.groupPrice,
    this.subStatus,
  });

  int wid;
  int createDate;
  int commentCount;
  int forwardCount;
  int likeCount;
  int shareCount;
  int isLike;
  int viewCount;
  _ListAuthor author;
  _ListWorks works;
  int canSee;
  int isForward;
  int canReply;
  int? isTopMost;
  int? groupPrice;
  int? subStatus;

  factory _ListElement.fromJson(Map<String, dynamic> json) => _ListElement(
        wid: json["wid"],
        createDate: json["createDate"],
        commentCount: json["commentCount"],
        forwardCount: json["forwardCount"],
        likeCount: json["likeCount"],
        shareCount: json["shareCount"],
        isLike: json["isLike"],
        viewCount: json["viewCount"],
        author: _ListAuthor.fromJson(json["author"]),
        works: _ListWorks.fromJson(json["works"]),
        canSee: json["canSee"],
        isForward: json["isForward"],
        canReply: json["canReply"],
        isTopMost: json["isTopMost"],
        groupPrice: json["groupPrice"],
        subStatus: json["subStatus"],
      );

  Map<String, dynamic> toJson() => {
        "wid": wid,
        "createDate": createDate,
        "commentCount": commentCount,
        "forwardCount": forwardCount,
        "likeCount": likeCount,
        "shareCount": shareCount,
        "isLike": isLike,
        "viewCount": viewCount,
        "author": author.toJson(),
        "works": works.toJson(),
        "canSee": canSee,
        "isForward": isForward,
        "canReply": canReply,
        "isTopMost": isTopMost,
        "groupPrice": groupPrice,
        "subStatus": subStatus,
      };
}

class _ListAuthor {
  _ListAuthor({
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

  factory _ListAuthor.fromJson(Map<String, dynamic> json) => _ListAuthor(
        userId: json["userId"],
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

class _ListWorks {
  _ListWorks({
    required this.replyPermission,
    required this.payPermission,
    required this.content,
    required this.pics,
    required this.video,
  });

  _ReplyPermission replyPermission;
  _FluffyPayPermission payPermission;
  String content;
  List<String> pics;
  _Video video;

  factory _ListWorks.fromJson(Map<String, dynamic> json) => _ListWorks(
        replyPermission: _ReplyPermission.fromJson(json["_ReplyPermission"]),
        payPermission: _FluffyPayPermission.fromJson(json["payPermission"]),
        content: json["content"],
        pics: List<String>.from(json["pics"].map((x) => x)),
        video: _Video.fromJson(json["video"]),
      );

  Map<String, dynamic> toJson() => {
        "_ReplyPermission": replyPermission.toJson(),
        "payPermission": payPermission.toJson(),
        "content": content,
        "pics": List<dynamic>.from(pics.map((x) => x)),
        "video": video.toJson(),
      };
}

class _Video {
  _Video({
    required this.snapshotUrl,
    required this.url,
    required this.format,
    required this.duration,
    required this.previewsUrls,
  });

  String snapshotUrl;
  String url;
  String format;
  int duration;
  List<String> previewsUrls;

  factory _Video.fromJson(Map<String, dynamic> json) => _Video(
        snapshotUrl: json["snapshot_url"] ?? '',
        url: json["url"] ?? '',
        format: json["format"] ?? '',
        duration: json["duration"] ?? 0,
        previewsUrls: json["previews_urls"] == null
            ? []
            : List<String>.from(json["previews_urls"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "snapshot_url": snapshotUrl,
        "url": url,
        "format": format,
        "duration": duration,
        "previews_urls": List<String>.from(previewsUrls.map((x) => x)),
      };
}

class _ReplyPermission {
  _ReplyPermission({
    required this.type,
    this.groupId,
  });

  int type;
  int? groupId;

  factory _ReplyPermission.fromJson(Map<String, dynamic> json) =>
      _ReplyPermission(
        type: json["type"],
        groupId: json["groupId"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "groupId": groupId,
      };
}

class _FluffyPayPermission {
  _FluffyPayPermission({
    required this.type,
    this.groupId,
    this.price,
  });

  int type;
  int? groupId;
  int? price;

  factory _FluffyPayPermission.fromJson(Map<String, dynamic> json) =>
      _FluffyPayPermission(
        type: json["type"],
        groupId: json["groupId"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "groupId": groupId,
        "price": price,
      };
}
