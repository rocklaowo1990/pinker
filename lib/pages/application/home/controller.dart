import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pinker/api/content.dart';
import 'package:pinker/entities/content_list.dart';
import 'package:pinker/entities/response.dart';
import 'package:pinker/global.dart';
import 'package:pinker/pages/application/home/library.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  HomeController();
  final HomeState state = HomeState();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  int pageIndex = 1;
  int totalSize = 0;

  void handleMail() {}

  void onRefresh() async {
    refreshController.resetNoData();
    // monitor network fetch
    await futureMill(1000);
    _refresh();
    await futureMill(1000);

    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await futureMill(2000);
    if (totalSize >= 20) {
      pageIndex++;
      Map<String, dynamic> data = {
        'pageNo': pageIndex,
        'pageSize': 20,
        'type': 2,
      };

      ResponseEntity responseEntity = await ContentApi.contentList(data);

      if (responseEntity.code == 200) {
        ContentList contentList = ContentList.fromJson(responseEntity.data);
        state.showList.addAll(contentList.list);
        state.isLoading = false;
        totalSize = contentList.totalSize;
        refreshController.loadComplete();
        Map<String, dynamic> _storageUserContentList = {
          'list': state.showList,
          'totalSize': state.showList.length,
        };
        await StorageUtil()
            .setJSON(storageUserContentListKey, _storageUserContentList);
      } else {
        pageIndex--;
        refreshController.loadFailed();

        getSnackTop(responseEntity.msg);
      }
    } else {
      refreshController.loadNoData();
    }

    // if failed,use loadFailed(),if no data return,use LoadNodata()
  }

  Future<void> _refresh() async {
    pageIndex = 1;
    totalSize = 0;
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
      totalSize = contentList.totalSize;
      await StorageUtil()
          .setJSON(storageUserContentListKey, responseEntity.data);
      await StorageUtil().setBool(storageIsHadUserInfo, true);
      Global.isHadUserInfo = true;
    } else {
      getSnackTop(responseEntity.msg);
    }
  }

  @override
  void onReady() async {
    super.onReady();
    if (Global.isHadUserInfo) {
      state.isLoading = false;
      Map<String, dynamic> _contentList =
          await StorageUtil().getJSON(storageUserContentListKey);
      ContentList contentList = ContentList.fromJson(_contentList);

      pageIndex = contentList.list.length ~/ 20;
      totalSize =
          contentList.list.length % 20 == 0 ? 20 : contentList.list.length % 20;

      print(pageIndex);
      print(totalSize);

      state.showList.addAll(contentList.list);
    } else {
      _refresh();
    }
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }
}
