import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotState {
  /// pageview
  final _pageCount = <Widget>[].obs;
  set pageCount(List<Widget> value) => _pageCount.value = value;
  List<Widget> get pageCount => _pageCount;

  /// pageview
  final _pageIndex = 0.obs;
  set pageIndex(int value) => _pageIndex.value = value;
  int get pageIndex => _pageIndex.value;
}
