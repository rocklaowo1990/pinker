import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/frame/register/controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

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
