// 返回数据格式化
class ResponseEntity {
  ResponseEntity({
    required this.code,
    required this.data,
    required this.msg,
  });

  int code;
  Map<String, dynamic> data;
  String msg;

  factory ResponseEntity.fromJson(Map<String, dynamic> json) => ResponseEntity(
        code: json["code"],
        data: json["data"] ?? {},
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data,
        "msg": msg,
      };
}
