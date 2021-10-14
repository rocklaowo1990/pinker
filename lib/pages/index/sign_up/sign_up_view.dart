import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/index/sign_up/controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp Page'),
      ),
    );
  }
}
