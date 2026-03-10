// lib/feature/shop/screen/shop_history_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widget/auth/custom_appbar.dart';
import '../controller/order_controller.dart';

class ShopHistoryScreen extends StatelessWidget {
  const ShopHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderController>();

    return Scaffold(
      appBar: CustomAppBar(title: 'Shop History'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.black));
        }
        if (controller.orders.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_bag_outlined,
                    size: 60.sp, color: Colors.black26),
                SizedBox(height: 12.h),
                Text('No orders yet.',
                    style: TextStyle(
                        fontSize: 16.sp, color: Colors.black54)),
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: controller.fetchOrders,
          color: Colors.black,
          child: ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: controller.orders.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: OrderCard(order: controller.orders[index]),
              );
            },
          ),
        );
      }),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderModel order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE8E8E8),
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.all(16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Product Image ───────────────────────────────────
          Container(
            width: 92.w,
            height: 92.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF5E6E0),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                'assets/images/shop/shopHistory.png',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                    Icons.shopping_bag,
                    color: Colors.grey,
                    size: 32.sp),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // ─── Order Details ───────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order #${order.id}',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(height: 4.h),
                // First product name
                Text(
                  order.orderItems.isNotEmpty
                      ? order.orderItems.first.product
                      : 'No items',
                  style: TextStyle(
                      fontSize: 12.sp, color: Colors.black54),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  order.shippingAddress,
                  style: TextStyle(
                      fontSize: 12.sp, color: Colors.black54),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  '\$${order.total.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Text(
                      order.displayStatus,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    if (order.showCheckmark) ...[
                      SizedBox(width: 6.w),
                      Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: order.statusColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check,
                            color: Colors.white, size: 13),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // ─── Right side ──────────────────────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${order.orderItems.length} item${order.orderItems.length > 1 ? 's' : ''}',
                style: TextStyle(
                    fontSize: 13.sp, color: Colors.black87),
              ),
              SizedBox(height: 8.h),
              // Paid badge
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: order.isPaid
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  order.isPaid ? 'Paid' : 'Unpaid',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: order.isPaid
                        ? Colors.green.shade800
                        : Colors.red.shade800,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  order.statusButton,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}