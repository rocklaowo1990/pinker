import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/personal/free/library.dart';
import 'package:pinker/pages/personal/library.dart';

import 'package:pinker/utils/utils.dart';

import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PersonalFreeController extends GetxController {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final PersonalController personalController = Get.find();
  final state = PersonalFreeState();
  int pageIndex = 1;

  void handleNoData() async {
    state.isLoading = true;
    await _getPersonalContent(1, personalController.state.personalFree);

    state.isLoading = false;
  }

  void onRefresh() async {
    refreshController.resetNoData();
    pageIndex = 1;
    await futureMill(300);
    await _getPersonalContent(1, personalController.state.personalFree);

    await futureMill(300);

    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await futureMill(300);
    if (personalController.state.personalFree.value.totalSize >= 20) {
      pageIndex++;

      ResponseEntity responseEntity = await ContentApi.userHomeContentList(
        pageNo: pageIndex,
        type: 5,
      );

      if (responseEntity.code == 200) {
        ContentListEntities contentList =
            ContentListEntities.fromJson(responseEntity.data);

        personalController.state.personalFree.update((val) {
          val!.list.addAll(contentList.list);
        });

        personalController.state.personalFree.value.totalSize =
            contentList.totalSize;
        refreshController.loadComplete();
      } else {
        pageIndex--;
        refreshController.loadFailed();
        getSnackTop(responseEntity.msg);
      }
    } else {
      refreshController.loadNoData();
    }
  }

  Future<void> _getPersonalContent(int type, Rx<ContentListEntities> rx) async {
    ResponseEntity responseEntity = await ContentApi.userHomeContentList(
      pageNo: 1,
      type: type,
      userId: personalController.arguments,
    );

    if (responseEntity.code == 200) {
      rx.value = ContentListEntities.fromJson(responseEntity.data);
      rx.update((val) {});
    } else {
      getSnackTop(responseEntity.msg);
    }
  }

  @override
  void onReady() async {
    super.onReady();

    if (personalController.state.personalFree.value.list.isEmpty) {
      await _getPersonalContent(5, personalController.state.personalFree);
      state.isLoading = false;
    } else {
      state.isLoading = false;
    }
  }
}
