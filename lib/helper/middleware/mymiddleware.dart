import 'package:flutter/material.dart';
import 'package:flutter_getx_starter/constants/approutes.dart';
import 'package:flutter_getx_starter/helper/functions/user_info.dart';
import 'package:get/get.dart';

/// Sends a signed-in user straight to the home screen.
class MyMiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (UserSession.isLoggedIn) {
      return const RouteSettings(name: AppRoute.home);
    }
    return null;
  }
}
