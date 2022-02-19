import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';

class ReplyState {
  final _replyPermissionType = 0.obs;
  set replyPermissionType(int value) => _replyPermissionType.value = value;
  int get replyPermissionType => _replyPermissionType.value;

  final _replyGroupId = 0.obs;
  set replyGroupId(int value) => _replyGroupId.value = value;
  int get replyGroupId => _replyGroupId.value;

  final _groupList = <GroupInfoEntities>[].obs;
  set groupList(List<GroupInfoEntities> value) => _groupList.value = value;
  List<GroupInfoEntities> get groupList => _groupList;
}
