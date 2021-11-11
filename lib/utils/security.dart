import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:pinker/values/values.dart';

/// MD5加密
String duMD5(String string) {
  var bytes = utf8.encode(string + salt);
  var digest = md5.convert(bytes);

  return digest.toString();
}

///
Future<dynamic> futureMill(int milliseconds) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}
