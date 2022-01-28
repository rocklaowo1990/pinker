class PublishEntities {
  PublishEntities({
    required this.content,
    required this.pics,
    required this.video,
    required this.payPermissionType,
    this.payGroupId,
    this.payPrice,
    this.limitFreeDays,
    required this.replyPermissionType,
    this.replyGroupId,
    this.mentionedUsers,
  });

  String content;
  String pics;
  String video;

  int payPermissionType;
  String? payGroupId;
  String? payPrice;
  String? limitFreeDays;
  int replyPermissionType;
  String? replyGroupId;
  String? mentionedUsers;

  factory PublishEntities.fromJson(Map<String, dynamic> json) =>
      PublishEntities(
        content: json["content"],
        pics: json["pics"],
        video: json["video"],
        payPermissionType: json["payPermissionType"],
        payGroupId: json["payGroupId"],
        payPrice: json["payPrice"],
        limitFreeDays: json["limitFreeDays"],
        replyPermissionType: json["replyPermissionType"],
        replyGroupId: json["replyGroupId"],
        mentionedUsers: json["mentionedUsers"],
      );

  Map<String, dynamic> toJson() => {
        'content': content,
        'pics': pics,
        'video': video,
        'payPermissionType': payPermissionType,
        'payGroupId': payGroupId,
        'payPrice': payPrice,
        'limitFreeDays': limitFreeDays,
        'replyPermissionType': replyPermissionType,
        'replyGroupId': replyGroupId,
        'mentionedUsers': mentionedUsers,
      };

  static Map<String, dynamic> child = {
    'content': '',
    'pics': '',
    'video': '',
    'payPermissionType': 0,
    'replyPermissionType': 1,
  };
}
