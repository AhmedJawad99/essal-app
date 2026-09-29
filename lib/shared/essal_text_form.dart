import 'package:flutter/material.dart';

class EssalTextForm extends StatelessWidget {
  const EssalTextForm({
    super.key,
    required this.controller,
    this.validator,
    required this.hintText,
    this.suffixIcon,
    this.isPassword = false,
    this.onPressed,
    this.icon,
  });

  final String Function(String?)? validator;
  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  final bool isPassword;
  final void Function()? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        suffixIcon:
            suffixIcon ??
            (icon != null
                ? IconButton(onPressed: onPressed, icon: Icon(icon))
                : null),
      ),
    );
  }
}
