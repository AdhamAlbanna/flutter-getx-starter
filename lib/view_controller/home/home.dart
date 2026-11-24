import 'package:flutter/material.dart';
import 'package:flutter_getx_starter/constants/appcolor.dart';
import 'package:flutter_getx_starter/helper/functions/user_info.dart';
import 'package:flutter_getx_starter/helper/widgets/appbar/customappbar.dart';
import 'package:flutter_getx_starter/view_controller/home/home_controller.dart';
import 'package:flutter_getx_starter/view_controller/home/items/product_item.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        backgroundColor: AppColor.white,
        appBar: CustomAppBar(
          title: 'home'.tr,
          actions: [
            IconButton(
              tooltip: 'change_language'.tr,
              onPressed: () => controller.changeLanguage(),
              icon: const Icon(Icons.translate, color: AppColor.black),
            ),
            IconButton(
              tooltip: 'logout'.tr,
              onPressed: () => controller.logout(),
              icon: const Icon(Icons.logout, color: AppColor.black),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'welcome_user'.trParams({'name': UserSession.name}),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'products'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColor.grey,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  itemCount: controller.products.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final product = controller.products[index];
                    return ProductItem(
                      title: product.title,
                      price: product.price,
                      imageUrl: product.thumbnail,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
