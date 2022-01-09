import 'package:get/get.dart';
import 'package:pinker/entities/group_list.dart';

class SetGroupState {
  /// 订阅分组
  final _groupList = <GroupInfoEntities>[].obs;
  set groupList(List<GroupInfoEntities> value) => _groupList.value = value;
  List<GroupInfoEntities> get groupList => _groupList;

  /// 正在请求数据
  final RxBool _isLoading = true.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;
}
