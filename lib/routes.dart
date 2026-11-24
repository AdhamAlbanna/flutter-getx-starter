import 'package:flutter_getx_starter/constants/approutes.dart';
import 'package:flutter_getx_starter/helper/middleware/mymiddleware.dart';
import 'package:flutter_getx_starter/view_controller/home/home.dart';
import 'package:flutter_getx_starter/view_controller/home/home_controller.dart';
import 'package:flutter_getx_starter/view_controller/login/login.dart';
import 'package:flutter_getx_starter/view_controller/login/login_controller.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>> routes = [
  GetPage(
    name: AppRoute.login,
    page: () => const Login(),
    binding: BindingsBuilder(() => Get.lazyPut(() => LoginController())),
    middlewares: [MyMiddleWare()],
  ),
  GetPage(
    name: AppRoute.home,
    page: () => const Home(),
    binding: BindingsBuilder(() => Get.lazyPut(() => HomeController())),
  ),
];
