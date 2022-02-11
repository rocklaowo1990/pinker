import 'package:device_info/device_info.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

class ConfigStore extends GetxController {
  static ConfigStore get to => Get.find();

  /// 系统类型
  String? platform;

  /// 手机系统版本
  String? osversion;

  /// APP版本
  String? version;

  /// 机型
  String? model;

  /// 包信息
  PackageInfo? packageInfo;

  @override
  void onInit() async {
    super.onInit();

    /// 读取设备信息
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (GetPlatform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      platform = 'android';
      osversion = 'Android ${androidInfo.version.sdkInt}';
      model = androidInfo.model;
    } else if (GetPlatform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      platform = 'ios';
      osversion = 'IOS ${iosInfo.systemVersion}';
      model = iosInfo.model;
    }

    /// 包信息
    packageInfo = await PackageInfo.fromPlatform();
  }
}
