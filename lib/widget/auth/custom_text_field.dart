// lib/widget/auth/custom_text_field.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final IconData? icon;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.obscureText = false,
    required this.controller,
    this.keyboardType,
    this.icon,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.all(5.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 10.w),
            if (widget.icon != null) ...[
              Icon(
                widget.icon,
                color: const Color(0xFF555555),
                size: 24.sp,
              ),
              SizedBox(width: 5.w),
            ],
            Expanded(
              child: TextField(
                controller: widget.controller,
                obscureText: _obscure,
                keyboardType: widget.keyboardType,
                style: TextStyle(fontSize: 16.sp),
                decoration: InputDecoration(
                  fillColor: const Color(0xFFE8E8E8),
                  hintText: widget.labelText,
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  // ─── Toggle icon only for password fields ──────────
                  suffixIcon: widget.obscureText
                      ? IconButton(
                    icon: Icon(
                      _obscure
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: const Color(0xFF555555),
                      size: 22.sp,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                  )
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}