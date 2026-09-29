import 'package:flutter/material.dart';

class EssalButton extends StatelessWidget {
  const EssalButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.text,
    required this.color,
    this.textColor = Colors.white,
  });
  final bool isLoading;
  final VoidCallback onPressed;
  final String text;
  final Color color;

  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isLoading ? color.withOpacity(0.5) : color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,

      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(text, style: TextStyle(color: textColor)),
    );
  }
}
