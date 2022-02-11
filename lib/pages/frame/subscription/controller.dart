import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/pages/frame/subscription/state.dart';

import 'package:pinker/routes/routes.dart';
import 'package:pinker/store/user.dart';

import 'package:pinker/utils/utils.dart';

import 'package:pinker/widgets/widgets.dart';

class SubscriptionController extends GetxController {
  /// 遮罩控制器
  final FrameController frameController = Get.find();

  /// 状态管理
  final SubscriptionState state = SubscriptionState();

  /// token
  final String token = UserStore.to.token;

  /// 下一步
  void handleNext() {
    Get.offAllNamed(AppRoutes.application);
  }

  void _sure(int index) async {
    Get.back();
    getDialog();
    ResponseEntity responseEntity = await UserApi.subscribeGroup(
      userId: state.userList.value.list[index].userId,
      groupId: state.userList.value.list[index].freeGroupId!,
    );

    if (responseEntity.code == 200) {
      await futureMill(500);
      Get.back();
      state.userList.update((val) {
        val!.list.remove(val.list[index]);
      });
    } else {
      await futureMill(200);
      Get.back();
      getSnackTop(responseEntity.msg);
    }
  }

  /// 订阅
  void handleSubscribe(int index) async {
    getDialog(
      child: DialogChild.alert(
        title: '订阅',
        content: '是否确认继续操作',
        onPressedRight: () {
          _sure(index);
        },
        leftText: '取消',
        onPressedLeft: () {
          Get.back();
        },
      ),
      autoBack: true,
    );
  }

  /// 请求数据
  Future<void> _getList() async {
    ResponseEntity responseEntity = await UserApi.list(
      type: 1,
      pageNo: 1,
    );
    if (responseEntity.code == 200) {
      UserListEntities _userList =
          UserListEntities.fromJson(responseEntity.data);

      state.userList.value = _userList;
      state.userList.update((val) {});
    } else {
      getSnackTop(responseEntity.msg);
    }
  }

  @override
  void onReady() async {
    super.onReady();
    await _getList();
  }
}
