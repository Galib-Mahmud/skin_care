import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final VoidCallback? onTap;

  const CustomBackButton({
    super.key,
    this.backgroundColor = const Color.fromRGBO(2, 9, 83, 1), // ✅ same style
    this.iconColor = Colors.white,
    this.size = 50,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.of(context).pop(),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_back,
          color: iconColor,
        ),
      ),
    );
  }
}
