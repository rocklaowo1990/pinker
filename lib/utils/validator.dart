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

/// 验证身份证
bool isIdCard(String value) {
  return RegExp(r"\d{17}[\d|x]|\d{15}").hasMatch(value);
}

/// 验证中文
bool isChinese(String value) {
  return RegExp(r"[\u4e00-\u9fa5]").hasMatch(value);
}

/// 验证码密码：8-16位，至少包含一个字母一个数字，其他不限制
/// r"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$"
bool isPassword(String value) {
  return RegExp(r"^(?=.*[a-z])(?=.*\d)[^]{8,16}$").hasMatch(value);
}

/// 取字符串后两位
String getLastTwo(String value) {
  if (value.isEmpty) return '';
  return value.substring(value.length - 2);
}

/// 隐藏邮箱地址
String getEmailHide(String value) {
  if (value.isEmpty) return '';
  List<String> part_1 = value.split('@');
  List<String> part_2 = part_1[1].split('.');
  return part_1[0].substring(part_1[0].length - 2) + '@' + part_2[0];
}
