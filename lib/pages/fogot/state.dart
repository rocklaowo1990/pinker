import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotState {
  /// 按钮是否禁用
  final RxBool _isDissable = true.obs;
  set isDissable(value) => _isDissable.value = value;
  bool get isDissable => _isDissable.value;

  /// pageview
  final _pageCount = <Widget>[].obs;
  set pageCount(List<Widget> value) => _pageCount.value = value;
  List<Widget> get pageCount => _pageCount.value;
}
