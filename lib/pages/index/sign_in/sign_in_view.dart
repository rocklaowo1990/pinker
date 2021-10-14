import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/index/sign_in/controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignIn Page'),
      ),
    );
  }
}
