class HomeSwiperKing {
  HomeSwiperKing({
    required this.carousel,
    required this.category,
  });

  List<_Carousel> carousel;
  List<_Category> category;

  factory HomeSwiperKing.fromJson(Map<String, dynamic> json) => HomeSwiperKing(
        carousel: List<_Carousel>.from(
            json["carousel"].map((x) => _Carousel.fromJson(x))),
        category: List<_Category>.from(
            json["category"].map((x) => _Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "carousel": List<dynamic>.from(carousel.map((x) => x.toJson())),
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
      };

  static Map<String, dynamic> child = {
    "carousel": <_Carousel>[],
    "category": <_Category>[],
  };
}

class _Carousel {
  _Carousel({
    required this.cid,
    required this.linkUrl,
    required this.pic,
  });

  int cid;
  String linkUrl;
  String pic;

  factory _Carousel.fromJson(Map<String, dynamic> json) => _Carousel(
        cid: json["cid"],
        linkUrl: json["linkUrl"],
        pic: json["pic"],
      );

  Map<String, dynamic> toJson() => {
        "cid": cid,
        "linkUrl": linkUrl,
        "pic": pic,
      };
}

class _Category {
  _Category({
    required this.cid,
    required this.name,
    required this.pic,
  });

  int cid;
  String name;
  String pic;

  factory _Category.fromJson(Map<String, dynamic> json) => _Category(
        cid: json["cid"],
        name: json["name"],
        pic: json["pic"],
      );

  Map<String, dynamic> toJson() => {
        "cid": cid,
        "name": name,
        "pic": pic,
      };
}

class HomeActivityList {
  HomeActivityList({
    required this.list,
    required this.totalSize,
  });

  List<_ActivityList> list;
  int totalSize;

  factory HomeActivityList.fromJson(Map<String, dynamic> json) =>
      HomeActivityList(
        list: List<_ActivityList>.from(
            json["list"].map((x) => _ActivityList.fromJson(x))),
        totalSize: json["totalSize"],
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "totalSize": totalSize,
      };

  static Map<String, dynamic> child = {
    "list": <_ActivityList>[],
    "totalSize": 0,
  };
}

class _ActivityList {
  _ActivityList({
    required this.aid,
    required this.avatar,
    required this.content,
    required this.desc,
    required this.endDate,
    required this.joinCount,
    required this.name,
    required this.startDate,
  });

  int aid;
  String avatar;
  String content;
  String desc;
  int endDate;
  int joinCount;
  String name;
  int startDate;

  factory _ActivityList.fromJson(Map<String, dynamic> json) => _ActivityList(
        aid: json["aid"],
        avatar: json["avatar"],
        content: json["content"],
        desc: json["desc"],
        endDate: json["endDate"],
        joinCount: json["joinCount"],
        name: json["name"],
        startDate: json["startDate"],
      );

  Map<String, dynamic> toJson() => {
        "aid": aid,
        "avatar": avatar,
        "content": content,
        "desc": desc,
        "endDate": endDate,
        "joinCount": joinCount,
        "name": name,
        "startDate": startDate,
      };
}
