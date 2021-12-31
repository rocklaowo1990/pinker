import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/dynamic/comments_view/library.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommentsViewController extends GetxController {
  final CommentsViewState state = CommentsViewState();
  final RefreshController refreshController = RefreshController();
  final ScrollController scrollController = ScrollController();

  final FocusNode focusNode = FocusNode();
  final TextEditingController textController = TextEditingController();
}
