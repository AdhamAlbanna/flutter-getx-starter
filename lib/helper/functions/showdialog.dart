import 'package:flutter/material.dart';
import 'package:get/get.dart';

void alertDialog(String title, String message) {
  Get.defaultDialog(
    title: title,
    middleText: message,
    textConfirm: 'OK'.tr,
    confirmTextColor: Colors.white,
    onConfirm: () => Get.back(),
  );
}
