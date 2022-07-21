import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  const CustomButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        primary: color,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700,
          fontSize: 17
        ),
      ),
    );
  }
}
