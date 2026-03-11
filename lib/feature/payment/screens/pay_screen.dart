import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';
import '../controllers/pay_controller.dart';

class PayScreen extends StatelessWidget {
  PayScreen({super.key});

  final PayController controller = Get.put(PayController());

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
            "stripe:version": "2024-06-20",
            "stripe:publishableKey": "pk_test_51T9fbJGmiuH1TWCJkdakHn9C6ASLHjkNus1N59aooE4LM65BduaKJ6GE9DKnhaH3UDMSH0aLES7hgMSGvGcVOb1K00yo5V9Ej9"
           
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pay')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (controller.devicePlatform == "Android")
              GooglePayButton(
                paymentConfiguration:
                PaymentConfiguration.fromJsonString(googlePayConfig),
                paymentItems: controller.paymentItems,
                type: GooglePayButtonType.buy,
                onPaymentResult: controller.handlePaymentResult,
                loadingIndicator: const CircularProgressIndicator(),
              ),

            const SizedBox(height: 20),

            if (controller.devicePlatform == "iOS")
              ApplePayButton(
                paymentConfiguration:
                PaymentConfiguration.fromJsonString(applePayConfig),
                paymentItems: controller.paymentItems,
                type: ApplePayButtonType.buy,
                onPaymentResult: controller.handlePaymentResult,
                loadingIndicator: const CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}