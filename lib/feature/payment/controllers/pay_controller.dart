import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pay/pay.dart';

class PayController extends GetxController {

  final devicePlatform = GetPlatform.isAndroid
      ? 'Android'
      : GetPlatform.isIOS
      ? 'iOS'
      : 'Unknown';

  final List<PaymentItem> paymentItems = const [
    PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];

  Future<void> handlePaymentResult(Map<String, dynamic> result) async {
    try {
      // Google Pay → Stripe token extract
      final tokenData = result['paymentMethodData']['tokenizationData']['token'];
      final tokenJson = jsonDecode(tokenData);
      final stripeToken = tokenJson['id']; // tok_test_XXXX

      print("Stripe Token: $stripeToken");

      // এটা তোমার backend এ পাঠাও
      await chargeFromBackend(stripeToken);

    } catch (e) {
      _showError("Error: $e");
    }
  }

  Future<void> chargeFromBackend(String stripeToken) async {
    try {
      final response = await http.post(
        Uri.parse('https://YOUR_BACKEND/api/payment/charge'), // ← তোমার backend URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': stripeToken,
          'amount': 9999, // cents = 99.99 USD
          'currency': 'usd',
        }),
      );

      if (response.statusCode == 200) {
        _showSuccess("Payment Successful 🎉");
      } else {
        _showError("Failed: ${response.body}");
      }

    } catch (e) {
      _showError("Network Error: $e");
    }
  }

  void _showSuccess(String msg) {
    Get.snackbar("✅ Success", msg,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  void _showError(String msg) {
    Get.snackbar("❌ Error", msg,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }
}