class CodeList {
  CodeList({
    this.list,
    this.totalSize,
  });

  List<ListElement>? list;
  int? totalSize;

  factory CodeList.fromJson(Map<String, dynamic> json) => CodeList(
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
        totalSize: json["totalSize"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? null
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "totalSize": totalSize,
      };
}

class ListElement {
  ListElement({
    this.id,
    this.country,
    this.opName,
    this.isOpen,
    this.areaCode,
    this.defaultLang,
    this.defaultCurrency,
    this.name,
  });

  int? id;
  String? country;
  String? opName;
  int? isOpen;
  String? areaCode;
  String? defaultLang;
  String? defaultCurrency;
  String? name;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        country: json["country"],
        opName: json["op_name"],
        isOpen: json["is_open"],
        areaCode: json["area_code"],
        defaultLang: json["default_lang"],
        defaultCurrency: json["default_currency"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "op_name": opName,
        "is_open": isOpen,
        "area_code": areaCode,
        "default_lang": defaultLang,
        "default_currency": defaultCurrency,
        "name": name,
      };
}
