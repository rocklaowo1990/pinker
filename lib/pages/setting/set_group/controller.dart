import 'package:get/get.dart';
import 'package:pinker/api/subscribe_group.dart';
import 'package:pinker/entities/group_list.dart';
import 'package:pinker/entities/response.dart';
import 'package:pinker/pages/setting/set_group/library.dart';

import 'package:pinker/routes/routes.dart';
import 'package:pinker/widgets/widgets.dart';

class SetGroupController extends GetxController {
  final state = SetGroupState();

  void handleEditGroup(GroupInfoEntities item) async {
    Get.toNamed(
      AppRoutes.set + AppRoutes.setGroup + AppRoutes.setGroupInfo,
      arguments: item,
    );
  }

  void handleAddGroup() async {
    Get.toNamed(AppRoutes.set + AppRoutes.setGroup + AppRoutes.setGroupInfo);
  }

  void response() async {
    ResponseEntity responseEntity = await SubscribeGroupApi.list(
      pageNo: 1,
    );
    if (responseEntity.code == 200) {
      GroupListEntities groupListEntities =
          GroupListEntities.fromJson(responseEntity.data);
      state.groupList.clear();
      state.groupList.addAll(groupListEntities.list);
      state.isLoading = false;
    } else {
      state.isLoading = false;

      getSnackTop(responseEntity.msg);
    }
  }

  @override
  void onReady() async {
    super.onReady();
    response();
  }
}
