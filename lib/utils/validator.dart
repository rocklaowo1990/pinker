/// 检查密码长度
bool duCheckStringLength(String? input, int length) {
  if (input == null || input.isEmpty) return false;
  return input.length >= length;
}

/// 手机号验证
bool isChinaPhoneLegal(String str) {
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