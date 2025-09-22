import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final IconData? icon; // Added optional icon parameter

  const CustomTextField({
    required this.labelText,
    this.obscureText = false,
    required this.controller,
    this.keyboardType,
    this.icon, // Added icon as an optional parameter
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        elevation: 3.0, // Added elevation
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)) ,
            prefixIcon: icon != null ? Icon(icon) : null, // Added icon
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          ),
        ),
      ),
    );
  }
}