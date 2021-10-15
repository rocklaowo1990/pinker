import 'package:flutter/material.dart';

/// 日志格式化
class Logger {
  static void write(String text, {bool isError = false}) {
    Future.microtask(() => debugPrint('** $text. isError: [$isError]'));
  }
}
