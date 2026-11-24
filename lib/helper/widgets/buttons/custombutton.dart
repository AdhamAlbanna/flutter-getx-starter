import 'package:flutter/material.dart';
import 'package:flutter_getx_starter/constants/appcolor.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 53,
      child: MaterialButton(
        color: AppColor.primaryColor,
        textColor: AppColor.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}
