import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/publish/library.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class PublishView extends GetView<PublishController> {
  const PublishView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var body = Container();
    return Scaffold(
      appBar: getNoLineBar('发推'),
      body: body,
      backgroundColor: AppColors.mainBacground,
    );
  }
}
