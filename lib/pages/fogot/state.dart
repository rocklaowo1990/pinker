import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotState {
  /// pageview
  final _pageCount = <Widget>[].obs;
  set pageCount(List<Widget> value) => _pageCount.value = value;
  List<Widget> get pageCount => _pageCount;

  /// 当前页面
  final _pageIndex = 0.obs;
  set pageIndex(int value) => _pageIndex.value = value;
  int get pageIndex => _pageIndex.value;

  /// 验证方式
  final RxInt _verifyType = 1.obs;
  set verifyType(int value) => _verifyType.value = value;
  int get verifyType => _verifyType.value;

  /// 发送验证码的时间
  final RxInt sendTimeRx = 0.obs;
  set sendTime(int value) => sendTimeRx.value = value;
  int get sendTime => sendTimeRx.value;
}
