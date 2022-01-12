import 'package:get/instance_manager.dart';
import 'package:pinker/pages/application/community/search/library.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(() => SearchController());
  }
}
