import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pinker/pages/application/chat/library.dart';

class ChatController extends GetxController {
  final ChatState state = ChatState();
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
}
