import 'package:flutter/material.dart';

class EssalTextFormField extends StatefulWidget {
  const EssalTextFormField({
    super.key,
    required this.controller,
    this.validator,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.isPassword = false,
    this.icon,
  });

  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isPassword;
  final IconData? icon;

  @override
  State<EssalTextFormField> createState() => _EssalTextFormFieldState();
}

class _EssalTextFormFieldState extends State<EssalTextFormField> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isPassword ? true : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: const OutlineInputBorder(),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isShow = !isShow;
                  });
                },
                icon: Icon(isShow ? Icons.visibility : Icons.visibility_off),
              )
            : widget.suffixIcon,

        prefixIcon: widget.prefixIcon,
      ),
    );
  }
}
