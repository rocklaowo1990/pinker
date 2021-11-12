import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/global.dart';

import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/pages/frame/subscription/state.dart';

import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/snackbar.dart';
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
    /// 读取token
    Global.token = StorageUtil().getJSON(storageUserTokenKey);
    Get.offAllNamed(AppRoutes.application);
  }

  /// 订阅
  void handleSubscribe(item) async {
    getDialog();
    Map<String, dynamic> data = {
      'userId': item['userId'],
      'groupId': item['freeGroupId'],
    };
    ResponseEntity subscribeGroup = await UserApi.subscribeGroup(data);

    if (subscribeGroup.code == 200) {
      await futureMill(200);
      Get.back();
      state.userList.remove(item);
      getSnackTop('订阅成功');
    } else {
      await futureMill(200);
      Get.back();
      getSnackTop(subscribeGroup.msg);
    }
  }

  /// 请求数据
  Future<dynamic> _getList() async {
    /// 开始请求
    Map<String, String> data = {
      'pageNo': '1',
      'pageSize': '20',
      'type': '1',
    };
    ResponseEntity getUserList = await UserApi.list(data);

    if (getUserList.code == 200) {
      state.userList = getUserList.data!['list'];
    } else {
      getSnackTop(getUserList.msg);
    }
  }

  @override
  void onInit() async {
    super.onInit();

    await _getList();
  }

  @override
  void dispose() {
    frameController.dispose();
    super.dispose();
  }
}
