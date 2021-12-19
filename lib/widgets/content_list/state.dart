import 'package:get/get.dart';

class ContentBoxState {
  // 是否显示资源的状态管理器
  final RxInt _canSee = 0.obs;
  set canSee(int value) => _canSee.value = value;
  int get canSee => _canSee.value;
}
