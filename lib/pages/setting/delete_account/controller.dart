import 'package:get/get.dart';
import 'package:pinker/pages/setting/delete_account/library.dart';

import 'package:pinker/routes/routes.dart';
import 'package:pinker/widgets/widgets.dart';

class DeleteAccountController extends GetxController {
  final state = DeleteAccountState();

  void handleDeleteAccount() async {
    /// 下一步按钮，点击事件
    getDialog(
      child: DialogChild.alert(
        onPressedLeft: _cancel,
        onPressedRight: _sure,
        title: '注销账号',
        content: '是否确认继续操作',
        leftText: '取消',
      ),
      autoBack: true,
    );
  }

  void _cancel() {
    Get.back();
  }

  void _sure() async {
    Get.back();
    Get.toNamed(
      AppRoutes.set + AppRoutes.checkPassword,
      arguments: AppRoutes.setVerify,
    );
  }
}
