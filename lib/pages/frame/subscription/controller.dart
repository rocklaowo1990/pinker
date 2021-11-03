import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/global.dart';

import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/pages/frame/subscription/state.dart';

import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/widgets/snackbar.dart';

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

  /// 订阅
  void handleSubscribe(item) async {
    Map<String, dynamic> data = {
      'userId': item['userId'],
    };
    ResponseEntity getSubscriben = await UserApi.oneSubscribeInfo(data);

    if (getSubscriben.code == 200) {
    } else {
      getSnackTop(getSubscriben.msg);
    }
  }

  @override
  void onInit() async {
    /// 开始请求
    Map<String, String> data = {
      'pageNo': '1',
      'pageSize': '20',
    };
    ResponseEntity getUserList =
        await UserApi.recommendUserListForRegister(data);

    if (getUserList.code == 200) {
      state.userList = getUserList.data!['list'];
    } else {
      getSnackTop(getUserList.msg);
    }
    super.onInit();
  }

  @override
  void dispose() {
    frameController.dispose();
    super.dispose();
  }
}
