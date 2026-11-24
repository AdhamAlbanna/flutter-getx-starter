import 'package:flutter_getx_starter/helper/functions/user_info.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  static const String _languageKey = 'language_code';

  late SharedPreferences sharedPreferences;

  Future<MyServices> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  String get languageCode => sharedPreferences.getString(_languageKey) ?? 'en';

  Future<void> saveLanguageCode(String code) =>
      sharedPreferences.setString(_languageKey, code);
}

Future<void> initialServices() async {
  await Get.putAsync(() => MyServices().init());
  await UserSession.init();
}
