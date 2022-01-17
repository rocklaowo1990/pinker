import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/application/library.dart';
import 'package:pinker/pages/personal/library.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class PersonalController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final PersonalState state = PersonalState();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final ApplicationController applicationController = Get.find();
  final ScrollController scrollController = ScrollController();

  late TabController tabController;
}
