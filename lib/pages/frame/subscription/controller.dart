import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/entities/user_list.dart';
import 'package:pinker/global.dart';

import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/pages/frame/subscription/state.dart';

import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';

import 'package:pinker/widgets/widgets.dart';

class SubscriptionController extends GetxController {
  /// 遮罩控制器
  final FrameController frameController = Get.find();

  /// 状态管理
  final SubscriptionState state = SubscriptionState();

  /// token
  final String token = Global.token ?? '';

  /// 下一步
  void handleNext() {
    Get.offAllNamed(AppRoutes.application);
  }

  void _sure(int index) async {
    Get.back();
    getDialog();
    ResponseEntity subscribeGroup = await UserApi.subscribeGroup(
      userId: state.userList.value.list[index].userId,
      groupId: state.userList.value.list[index].freeGroupId!,
    );

    if (subscribeGroup.code == 200) {
      await futureMill(1000);
      Get.back();
      state.userList.update((val) {
        val!.list.remove(val.list[index]);
      });
      getSnackTop(
        '订阅成功',
        isError: false,
      );
    } else {
      await futureMill(200);
      Get.back();
      getSnackTop(subscribeGroup.msg);
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
  Future<dynamic> _getList() async {
    ResponseEntity getUserList = await UserApi.list(pageNo: 1, type: 1);

    UserListEntities userList = UserListEntities.fromJson(getUserList.data);
    if (getUserList.code == 200) {
      state.userList.value = userList;
    } else {
      getSnackTop(getUserList.msg);
    }
  }

  @override
  void onReady() async {
    super.onReady();
    await _getList();
  }

  @override
  void dispose() {
    frameController.dispose();
    super.dispose();
  }
}
