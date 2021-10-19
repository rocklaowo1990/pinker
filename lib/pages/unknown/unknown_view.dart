import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/unknown/controller.dart';

class UnknownView extends GetView<UnknownController> {
  const UnknownView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UnknowView'),
      ),
    );
  }
}
