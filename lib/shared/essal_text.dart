import 'package:essal_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class EssalText extends StatelessWidget {
  const EssalText({
    super.key,
    required this.text,
    this.color = AppColors.textPrimary,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
  });
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
