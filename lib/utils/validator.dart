/// 检查密码长度
bool duCheckStringLength(String? input, int length) {
  if (input == null || input.isEmpty) return false;
  return input.length >= length;
}

/// 手机号验证
bool isChinaPhone(String str) {
  return RegExp(r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$")
      .hasMatch(str);
}

/// 纯数字验证
bool isNumber(String str) {
  return RegExp(r"^\d{8}$").hasMatch(str);
}

/// 邮箱验证
bool isEmail(String str) {
  return RegExp(r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$").hasMatch(str);
}

/// 验证URL
bool isUrl(String value) {
  return RegExp(r"^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+").hasMatch(value);
}

/// 字符串检索
bool isInclude(String value, String match) {
  return RegExp(r"(" + match + ")").hasMatch(value);
}

/// 验证身份证
bool isIdCard(String value) {
  return RegExp(r"\d{17}[\d|x]|\d{15}").hasMatch(value);
}

/// 验证中文
bool isChinese(String value) {
  return RegExp(r"[\u4e00-\u9fa5]").hasMatch(value);
}

/// 匹配中文，英文字母
bool getGroupName(String value) {
  return RegExp(r"^[a-zA-Z0-9_\u4e00-\u9fa5]+$").hasMatch(value);
}

/// 验证码密码：8-16位，至少包含一个字母一个数字，其他不限制
/// r"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$"
bool isPassword(String value) {
  return RegExp(r"^(?=.*[a-zA-Z])(?=.*\d)[^]{8,16}$").hasMatch(value);
}

/// 验证用户名 6-16位的字母和数字组合
bool isUserName(String value) {
  return RegExp(r"^[a-zA-Z](?=.*[a-zA-Z])(?=.*\d)[a-zA-Z0-9]{5,15}$")
      .hasMatch(value);
}

/// 验证用户名 6-16位 字母开头，可以包含数字和下划线
bool isUserNameSenond(String value) {
  return RegExp(r"^[a-zA-Z]\w{5,15}$").hasMatch(value);
}

/// 取字符串后两位:隐藏手机号码
String getLastTwo(String value) {
  if (value.isEmpty) return '';
  return value.substring(value.length - 2);
}

/// 隐藏邮箱地址
String getEmailHide(String value) {
  if (value.isEmpty) return '';
  List<String> part_1 = value.split('@');
  return getLastTwo(part_1[0]) + '@' + part_1[1];
}

/// 时间戳转时间
String getDate(int value) {
  String valueString = value.toString().substring(0, 13);
  int valueInt = int.parse(valueString);

  DateTime valueTime = DateTime.fromMillisecondsSinceEpoch(valueInt);
  String month =
      valueTime.month < 10 ? '0${valueTime.month}' : '${valueTime.month}';
  String day = valueTime.day < 10 ? '0${valueTime.day}' : '${valueTime.day}';

  return '${valueTime.year}-$month-$day';
}

String getResultTime(int value) {
  DateTime valueTime = DateTime.fromMillisecondsSinceEpoch(value);
  Duration cha = DateTime.now().difference(valueTime);

  return cha.toString();
}

/// 时间格式化
String getDuration(int value) {
  // 初始化
  // 首先默认所有的时间都是 0
  int minute = 0;
  int second = 0;
  int hour = 0;

  // 第一步是看分钟的数量
  minute = value ~/ 60;
  second = value % 60;
  String secondString = second < 10 ? '0$second' : '$second';

  if (minute < 10) {
    return '0$minute:$secondString';
  } else if (minute < 60) {
    return '$minute:$secondString';
  } else {
    hour = minute ~/ 60;
    minute = minute % 60;
    String hourString = hour < 10 ? '0$hour' : '$hour';
    String minuteString = minute < 10 ? '0$minute' : '$minute';
    return '$hourString:$minuteString:$secondString';
  }
}
