// lib/feature/shop/screen/place_order_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../routes/route_name.dart';
import 'controller/shop_controller.dart';


class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ShopController>();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => Navigator.maybePop(context),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 8.h, horizontal: 6.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back_ios_new_rounded,
                              size: 16.sp, color: Colors.black87),
                          SizedBox(width: 4.w),
                          Text('Back',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black87)),
                        ],
                      ),
                    ),
                  ),
                ),
                Text('Place order',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87)),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (c.isLoadingCart.value && c.cartItems.isEmpty) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.black));
        }
        if (c.cartItems.isEmpty) {
          return Center(
              child: Text('Cart is empty',
                  style: TextStyle(
                      fontSize: 15.sp, color: Colors.black54)));
        }

        final displayItems = c.cartItems.take(3).toList();
        final remaining = c.cartItems.length - 3;

        return Column(
          children: [
            SizedBox(height: 6.h),

            // ── Items ────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Column(
                children: displayItems.map((item) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: _OrderCard(
                      item: item,
                      onMinus: () {
                        if (item.quantity > 1) {
                          c.patchCartItem(
                              item.id, item.quantity - 1);
                        } else {
                          c.removeCartItem(item.id);
                        }
                      },
                      onPlus: () =>
                          c.patchCartItem(item.id, item.quantity + 1),
                    ),
                  );
                }).toList(),
              ),
            ),

            if (remaining > 0)
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Text('+$remaining more',
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),

            // ── Summary ──────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                children: [
                  _SummaryRow(
                      label: 'Subtotal',
                      value: c.cartSubtotal.toStringAsFixed(2)),
                  SizedBox(height: 8.h),
                  Container(
                      height: 1,
                      color: const Color(0xFFE5EDF2)),
                  SizedBox(height: 8.h),
                  _SummaryRow(
                      label: 'Delivery Charges',
                      value: '+3.99'),
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      Text('Total',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87)),
                      const Spacer(),
                      Text(c.cartTotal.toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87)),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ── Bottom bar ────────────────────────────────────
            SafeArea(
              top: false,
              minimum: EdgeInsets.only(
                  bottom: 130.h, left: 25.w, right: 15.w),
              child: Row(
                children: [
                  Text('\$ ${c.cartTotal.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87)),
                  const Spacer(),
                  SizedBox(
                    height: 50.h,
                    width: 230.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(24.r)),
                        elevation: 0,
                      ),
                      onPressed: () =>
                          Get.toNamed(RouteName.checkOut),
                      child: Text('Check Out',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard(
      {required this.item,
        required this.onMinus,
        required this.onPlus});
  final CartItemModel item;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.4),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5EDF2)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2))
        ],
      ),
      padding: EdgeInsets.all(10.w),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: item.productImage.isNotEmpty
                ? Image.network(item.productImage,
                width: 90.w,
                height: 82.w,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                    width: 90.w,
                    height: 82.w,
                    color: Colors.grey[200]))
                : Container(
                width: 90.w,
                height: 82.w,
                color: Colors.grey[200]),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 4.h),
                Text('\$${item.productPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 13.sp, color: Colors.black87)),
              ],
            ),
          ),
          _QtyPill(
              qty: item.quantity,
              onMinus: onMinus,
              onPlus: onPlus),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label,
            style:
            TextStyle(fontSize: 15.sp, color: Colors.black87)),
        const Spacer(),
        Text(value,
            style:
            TextStyle(fontSize: 15.sp, color: Colors.black87)),
      ],
    );
  }
}

class _QtyPill extends StatelessWidget {
  const _QtyPill(
      {required this.qty,
        required this.onMinus,
        required this.onPlus});
  final int qty;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    Widget btn(IconData ic, VoidCallback onTap) => InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 28.w,
        height: 28.w,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.4),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black12),
        ),
        alignment: Alignment.center,
        child: Icon(
            qty == 1 && ic == Icons.remove
                ? Icons.delete_outline
                : ic,
            size: 15.sp,
            color: Colors.black87),
      ),
    );
    return Container(
      padding:
      EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.4),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFE5EDF2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          btn(Icons.remove, onMinus),
          SizedBox(width: 8.w),
          Text('$qty',
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 13.sp)),
          SizedBox(width: 8.w),
          btn(Icons.add, onPlus),
        ],
      ),
    );
  }
}