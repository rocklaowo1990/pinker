class ContentListEntities {
  ContentListEntities({
    required this.list,
    required this.totalSize,
  });

  List<ListElement> list;
  int totalSize;

  factory ContentListEntities.fromJson(Map<String, dynamic> json) =>
      ContentListEntities(
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
        totalSize: json["totalSize"],
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "totalSize": totalSize,
      };
}

class ListElement {
  ListElement({
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
  ListAuthor author;
  ListWorks works;
  int canSee;
  int isForward;
  int canReply;
  int? isTopMost;
  int? groupPrice;
  int? subStatus;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        wid: json["wid"],
        createDate: json["createDate"],
        commentCount: json["commentCount"],
        forwardCount: json["forwardCount"],
        likeCount: json["likeCount"],
        shareCount: json["shareCount"],
        isLike: json["isLike"],
        viewCount: json["viewCount"],
        author: ListAuthor.fromJson(json["author"]),
        works: ListWorks.fromJson(json["works"]),
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

class ListAuthor {
  ListAuthor({
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

  factory ListAuthor.fromJson(Map<String, dynamic> json) => ListAuthor(
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

class ListWorks {
  ListWorks({
    required this.replyPermission,
    required this.payPermission,
    required this.content,
    required this.pics,
    required this.video,
  });

  ReplyPermission replyPermission;
  FluffyPayPermission payPermission;
  String content;
  List<String> pics;
  Video video;

  factory ListWorks.fromJson(Map<String, dynamic> json) => ListWorks(
        replyPermission: ReplyPermission.fromJson(json["replyPermission"]),
        payPermission: FluffyPayPermission.fromJson(json["payPermission"]),
        content: json["content"],
        pics: List<String>.from(json["pics"].map((x) => x)),
        video: Video.fromJson(json["video"]),
      );

  Map<String, dynamic> toJson() => {
        "replyPermission": replyPermission.toJson(),
        "payPermission": payPermission.toJson(),
        "content": content,
        "pics": List<dynamic>.from(pics.map((x) => x)),
        "video": video.toJson(),
      };
}

class Video {
  Video({
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

  factory Video.fromJson(Map<String, dynamic> json) => Video(
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
        "previews_urls": List<dynamic>.from(previewsUrls.map((x) => x)),
      };
}

class ReplyPermission {
  ReplyPermission({
    required this.type,
    this.groupId,
  });

  int type;
  int? groupId;

  factory ReplyPermission.fromJson(Map<String, dynamic> json) =>
      ReplyPermission(
        type: json["type"],
        groupId: json["groupId"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "groupId": groupId,
      };
}

class FluffyPayPermission {
  FluffyPayPermission({
    required this.type,
    this.groupId,
    this.price,
  });

  int type;
  int? groupId;
  int? price;

  factory FluffyPayPermission.fromJson(Map<String, dynamic> json) =>
      FluffyPayPermission(
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
