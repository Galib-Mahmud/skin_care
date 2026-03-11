// lib/feature/shop/screen/checkout_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../routes/route_name.dart';
import 'controller/shop_controller.dart';


class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ShopController>();
    final addressCtrl =
    TextEditingController(text: 'Home - 123 Main St, Apt 4B');

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
                Text('Checkout',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87)),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 8.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                _SelectionCard(
                  label: 'Deliver to',
                  leading: Icons.location_on_outlined,
                  value: addressCtrl.text,
                  onTap: () {},
                ),
                SizedBox(height: 10.h),
                _SelectionCard(
                  label: 'Payment from',
                  leading: Icons.credit_card,
                  value: 'Mastercard - Cash on Delivery',
                  onTap: () {},
                ),
              ],
            ),
          ),

          SizedBox(height: 18.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              children: [
                _SummaryRow(
                    label: 'Subtotal',
                    value: c.cartSubtotal.toStringAsFixed(2)),
                SizedBox(height: 8.h),
                Container(
                    height: 1, color: const Color(0xFFE5EDF2)),
                SizedBox(height: 8.h),
                _SummaryRow(
                    label: 'Delivery Charges', value: '+3.99'),
                SizedBox(height: 14.h),
                Container(
                    height: 1, color: const Color(0xFFE5EDF2)),
                SizedBox(height: 8.h),
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

          SafeArea(
            top: false,
            minimum: EdgeInsets.only(
                left: 30.w, right: 15.w, bottom: 130.h),
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
                    onPressed: c.isPlacingOrder.value
                        ? null
                        : () => c.placeOrder(
                        shippingAddress: addressCtrl.text,
                        paymentMethod: 'Cash on Delivery'),
                    child: c.isPlacingOrder.value
                        ? const CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2)
                        : Text('Proceed to Payment',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class _SelectionCard extends StatelessWidget {
  const _SelectionCard(
      {required this.label,
        required this.leading,
        required this.value,
        this.onTap});
  final String label;
  final IconData leading;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.4),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2))
        ],
      ),
      padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500)),
          SizedBox(height: 8.h),
          InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Icon(leading, size: 24.sp, color: Colors.black87),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600)),
                ),
                Icon(Icons.chevron_right_rounded,
                    size: 22.sp, color: Colors.black38),
              ],
            ),
          ),
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