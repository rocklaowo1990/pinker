// 找回密码时的数据格式化
class SetCountListEntities {
  SetCountListEntities({
    required this.title,
    required this.getCountUrl,
    required this.setCountUrl,
    required this.countType,
    required this.secondTitle,
    required this.dataName,
  });

  String title;
  String getCountUrl;
  String setCountUrl;
  String countType;
  String secondTitle;
  String dataName;

  factory SetCountListEntities.fromJson(Map<String, dynamic> json) =>
      SetCountListEntities(
        title: json["title"],
        getCountUrl: json["getCountUrl"],
        setCountUrl: json["setCountUrl"],
        countType: json["countType"],
        secondTitle: json["secondTitle"],
        dataName: json["dataName"],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'getCountUrl': getCountUrl,
        'setCountUrl': setCountUrl,
        'countType': countType,
        'secondTitle': secondTitle,
        'dataName': dataName,
      };
}
