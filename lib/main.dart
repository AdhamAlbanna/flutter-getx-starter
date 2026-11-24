import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getx_starter/constants/appcolor.dart';
import 'package:flutter_getx_starter/constants/approutes.dart';
import 'package:flutter_getx_starter/helper/services/services.dart';
import 'package:flutter_getx_starter/localization/mylocalization.dart';
import 'package:flutter_getx_starter/routes.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: MyLocalization(),
        locale: Locale(Get.find<MyServices>().languageCode),
        fallbackLocale: const Locale('en'),
        color: AppColor.primaryColor,
        theme: ThemeData(
          colorSchemeSeed: AppColor.primaryColor,
          useMaterial3: true,
        ),
        // Direction follows the active language (RTL for Arabic).
        builder: (context, child) => Directionality(
          textDirection: Get.locale?.languageCode == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: child!,
        ),
        initialRoute: AppRoute.login,
        getPages: routes,
      ),
    );
  }
}
