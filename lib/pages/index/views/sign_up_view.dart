import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/index/index.dart';

class SignUpView extends GetView<IndexController> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('SignUp Page'),
      ),
    );
  }
}
