import 'package:get/get.dart';
import 'package:pinker/api/subscribe_group.dart';
import 'package:pinker/entities/response.dart';
import 'package:pinker/pages/setting/set_group/library.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/widgets/widgets.dart';

class SetGroupController extends GetxController {
  final state = SetGroupState();

  void handleEditGroup(item) {
    Get.toNamed(
      AppRoutes.set + AppRoutes.setGroup + AppRoutes.setGroupInfo,
      arguments: item,
    );
  }

  void handleAddGroup() {
    Get.toNamed(
      AppRoutes.set + AppRoutes.setGroup + AppRoutes.setGroupInfo,
      arguments: 1,
    );
  }

  @override
  void onReady() async {
    super.onReady();
    ResponseEntity responseEntity = await SubscribeGroupApi.list();
    if (responseEntity.code == 200) {
      state.groupList = responseEntity.data!['list'];
      state.isLoading = false;
    } else {
      getSnackTop(responseEntity.msg);
    }
  }
}
