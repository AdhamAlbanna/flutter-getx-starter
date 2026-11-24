import 'package:flutter/material.dart';
import 'package:flutter_getx_starter/constants/appcolor.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  const CustomAppBar({super.key, required this.title, this.actions = const []});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: AppColor.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: actions,
    );
  }
}
