// lib/feature/shop/screen/checkout_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller/shop_controller.dart';


class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _addressCtrl = TextEditingController();
  final _addressFocus = FocusNode();

  @override
  void dispose() {
    _addressCtrl.dispose();
    _addressFocus.dispose();
    super.dispose();
  }

  // ── Address bottom sheet ──────────────────────────────────────────
  void _openAddressSheet() {
    final tempCtrl =
    TextEditingController(text: _addressCtrl.text);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          padding:
          EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              Text('Delivery Address',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87)),
              SizedBox(height: 6.h),
              Text('Enter your full delivery address',
                  style: TextStyle(
                      fontSize: 13.sp, color: Colors.black45)),
              SizedBox(height: 18.h),

              // Address text field
              TextField(
                controller: tempCtrl,
                autofocus: true,
                maxLines: 3,
                textInputAction: TextInputAction.done,
                style: TextStyle(
                    fontSize: 15.sp, color: Colors.black87),
                decoration: InputDecoration(
                  hintText:
                  'e.g. House 12, Road 5, Dhanmondi, Dhaka',
                  hintStyle: TextStyle(
                      fontSize: 14.sp, color: Colors.black38),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                        left: 12.w, right: 8.w, top: 12.h),
                    child: Icon(Icons.location_on_outlined,
                        size: 22.sp, color: Colors.black54),
                  ),
                  prefixIconConstraints:
                  const BoxConstraints(minWidth: 0),
                  filled: true,
                  fillColor: const Color(0xFFF5F7FA),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 14.w, vertical: 14.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                        color: Colors.black87, width: 1.5),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Save button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(14.r)),
                    elevation: 0,
                  ),
                  onPressed: () {
                    final addr = tempCtrl.text.trim();
                    if (addr.isEmpty) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                        content:
                        Text('Please enter your address'),
                      ));
                      return;
                    }
                    setState(() => _addressCtrl.text = addr);
                    Navigator.pop(context);
                  },
                  child: Text('Save Address',
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ShopController>();

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
                // ── Address card — tappable ──────────────────
                _SelectionCard(
                  label: 'Deliver to',
                  leading: Icons.location_on_outlined,
                  value: _addressCtrl.text.isEmpty
                      ? 'Tap to add delivery address'
                      : _addressCtrl.text,
                  isEmpty: _addressCtrl.text.isEmpty,
                  onTap: _openAddressSheet,
                ),
                SizedBox(height: 10.h),
                _SelectionCard(
                  label: 'Payment from',
                  leading: Icons.credit_card,
                  value: 'Cash on Delivery',
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
                    value:
                    '\$ ${c.cartSubtotal.toStringAsFixed(2)}'),
                SizedBox(height: 8.h),
                Container(
                    height: 1,
                    color: const Color(0xFFE5EDF2)),
                SizedBox(height: 8.h),
                _SummaryRow(
                    label: 'Delivery Charges',
                    value: '+\$ 3.99'),
                SizedBox(height: 14.h),
                Container(
                    height: 1,
                    color: const Color(0xFFE5EDF2)),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text('Total',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87)),
                    const Spacer(),
                    Text(
                        '\$ ${c.cartTotal.toStringAsFixed(2)}',
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
                        : () {
                      final addr =
                      _addressCtrl.text.trim();
                      if (addr.isEmpty) {
                        _openAddressSheet();
                        return;
                      }
                      c.placeOrder(
                        shippingAddress: addr,
                        paymentMethod:
                        'Cash on Delivery',
                      );
                    },
                    child: c.isPlacingOrder.value
                        ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2)
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

// ─── Reusable widgets ─────────────────────────────────────────────────────────

class _SelectionCard extends StatelessWidget {
  const _SelectionCard({
    required this.label,
    required this.leading,
    required this.value,
    this.isEmpty = false,
    this.onTap,
  });

  final String label;
  final IconData leading;
  final String value;
  final bool isEmpty;
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
                Icon(leading,
                    size: 24.sp,
                    color: isEmpty
                        ? Colors.black38
                        : Colors.black87),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(value,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: isEmpty
                              ? Colors.black38
                              : Colors.black87,
                          fontWeight: isEmpty
                              ? FontWeight.w400
                              : FontWeight.w600)),
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
            style: TextStyle(
                fontSize: 15.sp, color: Colors.black87)),
        const Spacer(),
        Text(value,
            style: TextStyle(
                fontSize: 15.sp, color: Colors.black87)),
      ],
    );
  }
}