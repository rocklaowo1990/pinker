import 'package:get/instance_manager.dart';
import 'package:pinker/pages/recommend_user_list/library.dart';

class RecommendUserListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecommendUserListController>(
        () => RecommendUserListController());
  }
}
