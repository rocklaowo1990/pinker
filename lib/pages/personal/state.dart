import 'package:get/get.dart';
import 'package:pinker/entities/personal.dart';

class PersonalState {
  /// 页面控制器
  final RxInt _pageIndex = 0.obs;
  set pageIndex(int value) => _pageIndex.value = value;
  int get pageIndex => _pageIndex.value;

  final intro = PersonalEntities.fromJson(PersonalEntities.child).obs;
}
