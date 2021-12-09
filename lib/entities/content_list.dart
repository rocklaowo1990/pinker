class ContentList {
  ContentList({
    required this.list,
    required this.totalSize,
  });

  List<ListElement> list;
  int totalSize;

  factory ContentList.fromJson(Map<String, dynamic> json) => ContentList(
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
    this.quoteSource,
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
  QuoteSource? quoteSource;

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
        quoteSource: json["quoteSource"] != null
            ? QuoteSource.fromJson(json["quoteSource"])
            : null,
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
        "quoteSource": quoteSource != null ? quoteSource!.toJson() : null,
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

class QuoteSource {
  QuoteSource({
    required this.wid,
    required this.author,
    required this.works,
  });

  String wid;
  QuoteSourceAuthor author;
  QuoteSourceWorks works;

  factory QuoteSource.fromJson(Map<String, dynamic> json) => QuoteSource(
        wid: json["wid"],
        author: QuoteSourceAuthor.fromJson(json["author"]),
        works: QuoteSourceWorks.fromJson(json["works"]),
      );

  Map<String, dynamic> toJson() => {
        "wid": wid,
        "author": author.toJson(),
        "works": works.toJson(),
      };
}

class QuoteSourceAuthor {
  QuoteSourceAuthor({
    required this.userId,
    required this.avatar,
    required this.nickName,
    required this.userName,
    required this.intro,
  });

  String userId;
  String avatar;
  String nickName;
  String userName;
  String intro;

  factory QuoteSourceAuthor.fromJson(Map<String, dynamic> json) =>
      QuoteSourceAuthor(
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

class QuoteSourceWorks {
  QuoteSourceWorks({
    this.content,
    this.video,
    this.pics,
    required this.replyPermission,
    required this.payPermission,
  });

  String? content;
  Video? video;
  List<String>? pics;
  ReplyPermission replyPermission;
  PurplePayPermission payPermission;

  factory QuoteSourceWorks.fromJson(Map<String, dynamic> json) =>
      QuoteSourceWorks(
        content: json["content"],
        video: Video.fromJson(json["video"]),
        pics: List<String>.from(json["pics"].map((x) => x)),
        replyPermission: ReplyPermission.fromJson(json["replyPermission"]),
        payPermission: PurplePayPermission.fromJson(json["payPermission"]),
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "video": video != null ? video!.toJson() : null,
        "pics": pics != null ? List<dynamic>.from(pics!.map((x) => x)) : null,
        "replyPermission": replyPermission.toJson(),
        "payPermission": payPermission.toJson(),
      };
}

class PurplePayPermission {
  PurplePayPermission({
    required this.type,
    this.groupId,
    this.price,
  });

  String type;
  String? groupId;
  String? price;

  factory PurplePayPermission.fromJson(Map<String, dynamic> json) =>
      PurplePayPermission(
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

class Video {
  Video({
    this.snapshotUrl,
    this.url,
    this.format,
    this.duration,
    this.previewsUrls,
  });

  String? snapshotUrl;
  String? url;
  String? format;
  int? duration;
  List<String>? previewsUrls;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        snapshotUrl: json["snapshot_url"],
        url: json["url"],
        format: json["format"],
        duration: json["duration"],
        previewsUrls: json["previews_urls"] != null
            ? List<String>.from(json["previews_urls"].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "snapshot_url": snapshotUrl,
        "url": url,
        "format": format,
        "duration": duration,
        "previews_urls": previewsUrls != null
            ? List<dynamic>.from(previewsUrls!.map((x) => x))
            : null,
      };
}

class ListWorks {
  ListWorks({
    required this.replyPermission,
    required this.payPermission,
    this.content,
    this.pics,
    this.video,
  });

  ReplyPermission replyPermission;
  FluffyPayPermission payPermission;
  String? content;
  List<String>? pics;
  Video? video;

  factory ListWorks.fromJson(Map<String, dynamic> json) => ListWorks(
        replyPermission: ReplyPermission.fromJson(json["replyPermission"]),
        payPermission: FluffyPayPermission.fromJson(json["payPermission"]),
        content: json["content"],
        pics: json["pics"] != null
            ? List<String>.from(json["pics"].map((x) => x))
            : null,
        video: json["video"] != null ? Video.fromJson(json["video"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "replyPermission": replyPermission.toJson(),
        "payPermission": payPermission.toJson(),
        "content": content,
        "pics": pics != null ? List<dynamic>.from(pics!.map((x) => x)) : null,
        "video": video != null ? video!.toJson() : null,
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
