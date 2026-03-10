// lib/feature/shop/controller/history_order_controller.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/endpoint/api_client.dart';
import '../../../core/endpoint/api_endpoint.dart';

class OrderItemModel {
  final int id;
  final String product;
  final int quantity;
  final String price;
  final double totalPrice;

  OrderItemModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.price,
    required this.totalPrice,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id         : json['id'],
      product    : json['product']     ?? '',
      quantity   : json['quantity']    ?? 1,
      price      : json['price']       ?? '0.00',
      totalPrice : (json['total_price'] ?? 0).toDouble(),
    );
  }
}

class OrderModel {
  final int id;
  final String user;
  final String shippingAddress;
  final String orderStatus;
  final String? paymentMethod;
  final bool isPaid;
  final String deliveryCharges;
  final String createdAt;
  final List<OrderItemModel> orderItems;
  final double subtotal;
  final double total;

  OrderModel({
    required this.id,
    required this.user,
    required this.shippingAddress,
    required this.orderStatus,
    this.paymentMethod,
    required this.isPaid,
    required this.deliveryCharges,
    required this.createdAt,
    required this.orderItems,
    required this.subtotal,
    required this.total,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final items = (json['order_items'] as List? ?? [])
        .map((e) => OrderItemModel.fromJson(e))
        .toList();
    return OrderModel(
      id              : json['id'],
      user            : json['user']             ?? '',
      shippingAddress : json['shipping_address'] ?? '',
      orderStatus     : json['order_status']     ?? '',
      paymentMethod   : json['payment_method'],
      isPaid          : json['is_paid']          ?? false,
      deliveryCharges : json['delivery_charges'] ?? '0.00',
      createdAt       : json['created_at']       ?? '',
      orderItems      : items,
      subtotal        : (json['subtotal']        ?? 0).toDouble(),
      total           : (json['total']           ?? 0).toDouble(),
    );
  }

  // ─── UI helpers ─────────────────────────────────────────────────
  String get displayStatus {
    switch (orderStatus.toLowerCase()) {
      case 'delivered' : return 'Delivered';
      case 'shipped'   : return 'Shipped';
      case 'packed'    : return 'Packed';
      case 'in process': return 'In Process';
      default          : return orderStatus;
    }
  }

  String get statusButton {
    switch (orderStatus.toLowerCase()) {
      case 'delivered' : return 'Complete';
      case 'shipped'   : return 'Shipped';
      case 'in process': return 'In Process';
      case 'packed'    : return 'Packed';
      default          : return orderStatus;
    }
  }

  bool get showCheckmark =>
      ['delivered', 'shipped', 'in process']
          .contains(orderStatus.toLowerCase());

  Color get statusColor {
    switch (orderStatus.toLowerCase()) {
      case 'delivered' : return Colors.green;
      case 'shipped'   : return Colors.blue;
      case 'in process': return Colors.orange;
      case 'packed'    : return Colors.grey;
      default          : return Colors.black;
    }
  }
}

class OrderController extends GetxController {

  static OrderController get to => Get.find();
  final ApiClient _apiClient = ApiClient(baseUrl: ApiEndpoint.baseUrl);

  final RxList<OrderModel> orders = <OrderModel>[].obs;
  final RxBool isLoading          = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  // ──────────────────────────────────────────────────────────────────
  // GET /api/v1/shop/orders/
  // ──────────────────────────────────────────────────────────────────
  Future<void> fetchOrders() async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get(
        '/api/v1/shop/orders/',
        requiresAuth: true,
      );
      if (response != null && response is List) {
        orders.value =
            response.map((e) => OrderModel.fromJson(e)).toList();
      }
    } on HttpException catch (e) {
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
    } catch (e) {
      print('❌ fetchOrders error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ─── Helpers ──────────────────────────────────────────────────────
  Map<String, dynamic>? _tryParseBody(String? body) {
    if (body == null || body.trim().isEmpty) return null;
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) return decoded;
    } catch (_) {}
    return null;
  }

  String? _extractMessage(Map<String, dynamic>? body) {
    if (body == null) return null;
    if (body.containsKey('detail')) return body['detail'].toString();
    for (final entry in body.entries) {
      final val = entry.value;
      if (val is List && val.isNotEmpty) return val.first.toString();
      if (val is String) return val;
    }
    return null;
  }

  void _showError(String message) {
    final context = Get.context;
    if (context == null) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.red.shade700,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }
}