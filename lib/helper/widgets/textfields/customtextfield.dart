import 'package:flutter/material.dart';
import 'package:flutter_getx_starter/constants/appcolor.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController mycontroller;
  final String hint;
  final String? Function(String?)? valid;
  final TextInputType textInputType;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.mycontroller,
    required this.hint,
    this.valid,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: AppColor.border),
    );

    return TextFormField(
      controller: mycontroller,
      validator: valid,
      keyboardType: textInputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: const BorderSide(color: AppColor.primaryColor),
        ),
      ),
    );
  }
}
