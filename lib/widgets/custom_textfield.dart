import 'package:flutter/material.dart';

// Custom reusable TextField widget
Widget customTextField({
  required TextEditingController controller,
  required String labelText,
  required String hintText,
  bool obscureText = false,
  Widget? suffixIcon,
  TextInputType keyboardType = TextInputType.text, required Key key,
}) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
    cursorColor: const Color.fromARGB(255, 68, 91, 75),
    style: const TextStyle(color: Color.fromARGB(255, 68, 91, 75)),
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
      hintText: hintText,
      hintStyle: const TextStyle(color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromARGB(255, 68, 91, 75)),
        borderRadius: BorderRadius.circular(30),
      ),
      suffixIcon: suffixIcon,
    ),
  );
}
