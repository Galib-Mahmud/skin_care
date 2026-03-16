import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackbar {
  // Success
  static void success(String message) {
    _show(message, Get.theme.colorScheme.secondary, Icons.check_circle);
  }

  // Error
  static void error(String message) {
    _show(message, Colors.red.shade600, Icons.error);
  }

  // Info
  static void info(String message) {
    _show(message, Colors.blue.shade600, Icons.info);
  }

  // Warning
  static void warning(String message) {
    _show(message, Colors.orange.shade800, Icons.warning_amber_rounded);
  }

  // Private helper function
  static void _show(String message, Color bgColor, IconData icon) {
    // ✅ Safe context check
    final ctx = Get.overlayContext ?? Get.context;
    if (ctx == null) return;

    ScaffoldMessenger.of(ctx).clearSnackBars(); // remove previous
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        duration: const Duration(seconds: 2),
        elevation: 4,
      ),
    );
  }
}