import 'package:flutter/material.dart';
import 'package:flutter_getx_starter/Network/api.dart';
import 'package:flutter_getx_starter/Network/api_links.dart';
import 'package:flutter_getx_starter/constants/approutes.dart';
import 'package:flutter_getx_starter/helper/functions/user_info.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController username;
  late TextEditingController password;
  final RxBool hidePassword = true.obs;

  @override
  void onInit() {
    // Demo credentials for dummyjson.com; remove for a real backend.
    username = TextEditingController(text: 'emilys');
    password = TextEditingController(text: 'emilyspass');
    super.onInit();
  }

  @override
  void onClose() {
    username.dispose();
    password.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() => hidePassword.toggle();

  Future<void> login() async {
    if (!formstate.currentState!.validate()) return;

    final response = await Api.makeApiRequest(
      url: ApiLinks.login,
      method: 'POST',
      body: {'username': username.text.trim(), 'password': password.text},
    );

    if (response['success'] == true) {
      await UserSession.save({
        'token': response['accessToken'],
        'id': response['id'],
        'name': response['firstName'],
        'email': response['email'],
      });
      Get.offAllNamed(AppRoute.home);
    }
  }
}
