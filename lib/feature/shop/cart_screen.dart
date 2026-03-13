// lib/feature/shop/screen/cart_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skincare/core/endpoint/api_endpoint.dart';
import '../../../routes/route_name.dart';
import 'controller/shop_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ShopController());

    return Scaffold(
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
                Text('Cart',
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shopping_cart_outlined,
                    size: 60.sp, color: Colors.black26),
                SizedBox(height: 12.h),
                Text('Your cart is empty',
                    style: TextStyle(
                        fontSize: 16.sp, color: Colors.black54)),
              ],
            ),
          );
        }

        return Column(
          children: [
            SizedBox(height: 6.h),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                itemCount: c.cartItems.length,
                separatorBuilder: (_, __) => SizedBox(height: 8.h),
                itemBuilder: (context, i) {
                  final item = c.cartItems[i];
                  return _CartCard(
                    item: item,
                    onMinus: () {
                      if (item.quantity > 1) {
                        c.patchCartItem(item.id, item.quantity - 1);
                      } else {
                        c.removeCartItem(item.id);
                      }
                    },
                    onPlus: () =>
                        c.patchCartItem(item.id, item.quantity + 1),
                    onRemove: () => c.removeCartItem(item.id),
                  );
                },
              ),
            ),

            // ── Total + Continue ─────────────────────────────────
            Padding(
              padding: EdgeInsets.only(
                  bottom: 140.h, left: 30.w, right: 30.w),
              child: Row(
                children: [
                  Obx(() => Text(
                    '\$ ${c.cartSubtotal.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  )),
                  const Spacer(),
                  SizedBox(
                    height: 44.h,
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
                          Get.toNamed(RouteName.placeOrder),
                      child: Text('Continue',
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

class _CartCard extends StatelessWidget {
  const _CartCard({
    required this.item,
    required this.onMinus,
    required this.onPlus,
    required this.onRemove,
  });
  final CartItemModel item;
  final VoidCallback onMinus;
  final VoidCallback onPlus;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.4),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5EDF2)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 3))
        ],
      ),
      padding: EdgeInsets.all(10.w),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: item.productImage.isNotEmpty
                ? Image.network("${ApiEndpoint.baseUrl}${item.productImage}",
                width: 56.w,
                height: 56.w,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(
                        width: 56.w,
                        height: 56.w,
                        color: Colors.grey[200]))
                : Container(
                width: 56.w,
                height: 56.w,
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
                Text(
                    '\$${item.productPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 13.sp)),
              ],
            ),
          ),
          InkWell(
            onTap: onRemove,
            child: Container(
              width: 32.w,
              height: 32.w,
              margin: EdgeInsets.only(right: 8.w),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 0.4),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.black12),
              ),
              alignment: Alignment.center,
              child: Icon(Icons.delete_outline,
                  size: 18.sp, color: Colors.black54),
            ),
          ),
          _QtyPill(
              qty: item.quantity, onMinus: onMinus, onPlus: onPlus),
        ],
      ),
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
        child: Icon(ic, size: 16.sp, color: Colors.black87),
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