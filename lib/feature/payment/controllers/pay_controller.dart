import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pay/pay.dart';

class PayController extends GetxController {

  final String googlePayConfig = '''
{
  "provider": "google_pay",
  "data": {
    "environment": "TEST",
    "apiVersion": 2,
    "apiVersionMinor": 0,
    "allowedPaymentMethods": [
      {
        "type": "CARD",
        "parameters": {
          "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
          "allowedCardNetworks": ["AMEX", "DISCOVER", "MASTERCARD", "VISA"]
        },
        "tokenizationSpecification": {
          "type": "PAYMENT_GATEWAY",
          "parameters": {
            "gateway": "stripe",
            "stripe:publishableKey": "pk_test_51T9fbJGmiuH1TWCJkdakHn9C6ASLHjkNus1N59aooE4LM65BduaKJ6GE9DKnhaH3UDMSH0aLES7hgMSGvGcVOb1K00yo5V9Ej9",
            "stripe:version":"2024-06-20"
          }
        }
      }
    ],
    "merchantInfo": {
      "merchantName": "Test Store"
    },
    "transactionInfo": {
      "totalPriceStatus": "FINAL",
      "totalPrice": "99.99",
      "currencyCode": "USD",
      "countryCode": "US"
    }
  }
}
''';



  final String applePayConfig = '''
{
  "provider": "apple_pay",
  "data": {
    "merchantIdentifier": "merchant.com.YOUR_BUNDLE_ID",
    "displayName": "Demo Store",
    "merchantCapabilities": ["supports3DS"],
    "supportedNetworks": ["visa", "masterCard", "amex", "discover"],
    "countryCode": "US",
    "currencyCode": "USD"
  }
}
''';

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