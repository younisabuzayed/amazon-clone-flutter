import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int maxLines;
  final Widget? suffixIcon;
  final bool obscureText;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.maxLines = 1,
    this.obscureText = false,
    this.suffixIcon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        label: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38)),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $label';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
