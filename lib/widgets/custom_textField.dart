import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData? prefixIcon;
  final String hintAndLabelText;
  final bool obscureText;
  final TextInputType keynoardType;
  final TextEditingController? controller;

  CustomTextField({
    this.prefixIcon,
    required this.hintAndLabelText,
    this.obscureText = false,
    this.keynoardType = TextInputType.text,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller ?? null,
      keyboardType: keynoardType,
      style: TextStyle(
        color: Colors.orange,
      ),
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Colors.white,
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.orangeAccent,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.orangeAccent,
          ),
        ),
        hintText: hintAndLabelText,
        labelText: hintAndLabelText,
        labelStyle: TextStyle(
          color: Colors.orange,
        ),
        hintStyle: TextStyle(
          color: Colors.orange.shade200,
        ),
      ),
    );
  }
}
