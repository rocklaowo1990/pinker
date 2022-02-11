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

  // 下方是参考代码
  // bool isFirstOpen = false;
  // PackageInfo? _platform;
  // String get version => _platform?.version ?? '-';
  // bool get isRelease => const bool.fromEnvironment("dart.vm.product");
  // Locale locale = const Locale('en', 'US');
  // List<Locale> languages = const [
  //   Locale('en', 'US'),
  //   Locale('zh', 'CN'),
  // ];

  // @override
  // void onInit() {
  //   super.onInit();
  //   isFirstOpen = StorageService.to.getBool(STORAGE_DEVICE_FIRST_OPEN_KEY);
  // }

  // Future<void> getPlatform() async {
  //   _platform = await PackageInfo.fromPlatform();
  // }

  // // 标记用户已打开APP
  // Future<bool> saveAlreadyOpen() {
  //   return StorageService.to.setBool(STORAGE_DEVICE_FIRST_OPEN_KEY, false);
  // }

  // void onInitLocale() {
  //   var langCode = StorageService.to.getString(STORAGE_LANGUAGE_CODE);
  //   if (langCode.isEmpty) return;
  //   var index = languages.indexWhere((element) {
  //     return element.languageCode == langCode;
  //   });
  //   if (index < 0) return;
  //   locale = languages[index];
  // }

  // void onLocaleUpdate(Locale value) {
  //   locale = value;
  //   Get.updateLocale(value);
  //   StorageService.to.setString(STORAGE_LANGUAGE_CODE, value.languageCode);
  // }

  // /// 持久化 用户信息
  // static Future<bool> saveToken(String token) {
  //   token = token;
  //   return StorageService().setString(storageUserTokenKey, token);
  // }
}
