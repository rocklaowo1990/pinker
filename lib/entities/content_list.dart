class ContentListEntities {
  ContentListEntities({
    required this.list,
    required this.totalSize,
  });

  List<ContentDetailElement> list;
  int totalSize;

  factory ContentListEntities.fromJson(Map<String, dynamic> json) =>
      ContentListEntities(
        list: List<ContentDetailElement>.from(
            json["list"].map((x) => ContentDetailElement.fromJson(x))),
        totalSize: json["totalSize"],
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "totalSize": totalSize,
      };

  static Map<String, dynamic> child = {
    "list": [
      {
        "wid": 0,
        "createDate": 1641542124036,
        "commentCount": 0,
        "forwardCount": 0,
        "likeCount": 0,
        "shareCount": 0,
        "isLike": 0,
        "viewCount": 0,
        "author": {
          "userId": 0,
          "avatar": '',
          "nickName": '',
          "userName": '',
          "intro": '',
        },
        "works": {
          "replyPermission": {
            "type": 0,
            "isLimitFree": 0,
          },
          "payPermission": {
            "type": 0,
            "isLimitFree": 0,
          },
          "content": '',
          "pics": [],
          "video": {
            "snapshot_url": '',
            "url": '',
            "format": '',
            "duration": 0,
            "previews_urls": [],
          },
        },
        "canSee": 0,
        "isForward": 0,
        "canReply": 0,
      }
    ],
    "totalSize": 0,
  };
}

class ContentDetailElement {
  ContentDetailElement({
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
  _Author author;
  _Works works;
  int canSee;
  int isForward;
  int canReply;
  int? isTopMost;
  int? groupPrice;
  int? subStatus;

  factory ContentDetailElement.fromJson(Map<String, dynamic> json) =>
      ContentDetailElement(
        wid: json["wid"],
        createDate: json["createDate"],
        commentCount: json["commentCount"],
        forwardCount: json["forwardCount"],
        likeCount: json["likeCount"],
        shareCount: json["shareCount"],
        isLike: json["isLike"],
        viewCount: json["viewCount"],
        author: _Author.fromJson(json["author"]),
        works: _Works.fromJson(json["works"]),
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

class _Works {
  _Works({
    required this.replyPermission,
    required this.payPermission,
    required this.content,
    required this.pics,
    required this.video,
  });

  _ReplyPermission replyPermission;
  _PayPermission payPermission;
  String content;
  List<String> pics;
  _Video video;

  factory _Works.fromJson(Map<String, dynamic> json) => _Works(
        replyPermission: _ReplyPermission.fromJson(json["replyPermission"]),
        payPermission: _PayPermission.fromJson(json["payPermission"]),
        content: json["content"],
        pics: List<String>.from(json["pics"].map((x) => x)),
        video: _Video.fromJson(json["video"]),
      );

  Map<String, dynamic> toJson() => {
        "replyPermission": replyPermission.toJson(),
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

class _PayPermission {
  _PayPermission({
    required this.type,
    this.groupId,
    this.price,
    required this.isLimitFree,
  });

  int type;
  int? groupId;
  int? price;
  int isLimitFree;

  factory _PayPermission.fromJson(Map<String, dynamic> json) => _PayPermission(
        type: json["type"],
        groupId: json["groupId"],
        price: json["price"],
        isLimitFree: json["isLimitFree"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "groupId": groupId,
        "price": price,
        "isLimitFree": isLimitFree,
      };
}
