import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pinker/api/content.dart';
import 'package:pinker/entities/content_list.dart';
import 'package:pinker/entities/response.dart';
import 'package:pinker/pages/application/home/library.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  HomeController();
  final HomeState state = HomeState();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  int pageIndex = 1;

  void handleMail() {}

  void onRefresh() async {
    // monitor network fetch
    await futureMill(1000);
    _refresh();
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await futureMill(1000);
    _loading();
    refreshController.refreshCompleted();

    // if failed,use loadFailed(),if no data return,use LoadNodata()
  }

  Future<void> _refresh() async {
    pageIndex = 1;
    Map<String, dynamic> data = {
      'pageNo': 1,
      'pageSize': 20,
      'type': 2,
    };

    ResponseEntity responseEntity = await ContentApi.contentList(data);
    if (responseEntity.code == 200) {
      ContentList contentList = ContentList.fromJson(responseEntity.data);
      state.showList.clear();
      state.showList.addAll(contentList.list);
      state.isLoading = false;
    } else {
      getSnackTop(responseEntity.msg);
    }
  }

  Future<void> _loading() async {
    pageIndex++;
    Map<String, dynamic> data = {
      'pageNo': pageIndex,
      'pageSize': 20,
      'type': 2,
    };
    print(pageIndex);
    ResponseEntity responseEntity = await ContentApi.contentList(data);
    print(responseEntity.code);
    if (responseEntity.code == 200) {
      ContentList contentList = ContentList.fromJson(responseEntity.data);
      state.showList.addAll(contentList.list);
      state.isLoading = false;
    } else {
      pageIndex--;
      getSnackTop(responseEntity.msg);
    }
  }

  @override
  void onReady() async {
    super.onReady();

    _refresh();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }
}
