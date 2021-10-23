import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/fogot/library.dart';

class ForgotView extends GetView<ForgotController> {
  const ForgotView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot'),
      ),
    );
  }
}
