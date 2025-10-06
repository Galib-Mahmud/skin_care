import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // Numbers chosen to match your screenshot (28.13 + 3.99 = 32.12)
  double subtotal = 28.13;
  double delivery = 3.99;

  @override
  Widget build(BuildContext context) {
    final total = subtotal + delivery;

    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),

      // Header area
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
                      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back_ios_new_rounded, size: 16.sp, color: Colors.black87),
                          SizedBox(width: 4.w),
                          Text('Back', style: TextStyle(fontSize: 14.sp, color: Colors.black87)),
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 28.w,
                    height: 28.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 8.h),

          // ---- Selection Cards ----
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              children: [
                _SelectionCard(
                  label: 'Deliver to',
                  leading: Icons.location_on_outlined,
                  value: 'Home - 123 Main St, Apt 4B',
                  onTap: () {
                    // TODO: choose address
                  },
                ),
                SizedBox(height: 10.h),
                _SelectionCard(
                  label: 'Payment from',
                  leading: Icons.credit_card,
                  value: 'Mastercard - Daniel Jones',
                  onTap: () {
                    // TODO: choose payment
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 18.h),

          // ---- Summary ----
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              children: [
                _SummaryRow(label: 'Subtotal', value: subtotal.toStringAsFixed(2)),
                SizedBox(height: 8.h),
                Container(height: 1, color: const Color(0xFFE5EDF2)), // divider
                SizedBox(height: 8.h),
                _SummaryRow(label: 'Delivery Charges', value: '+${delivery.toStringAsFixed(2)}'),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      total.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Spacer(),

          // ---- Bottom amount + button ----
          SafeArea(
            top: false,
            minimum: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 12.h),
            child: Row(
              children: [
                Text(
                  '\$ ${total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 46.h,
                  width: 220.w, // wider like the mock
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      // TODO: proceed to payment
                    },
                    child: Text(
                      'Proceed to Payment',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ===== Widgets =====

class _SelectionCard extends StatelessWidget {
  const _SelectionCard({
    required this.label,
    required this.leading,
    required this.value,
    this.onTap,
  });

  final String label;
  final IconData leading;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // subtle label
          Text(
            label,
            style: TextStyle(
              fontSize: 11.5.sp,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10.r),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Row(
                children: [
                  Container(
                    width: 34.w,
                    height: 34.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    alignment: Alignment.center,
                    child: Icon(leading, size: 18.sp, color: Colors.black87),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.sp, color: Colors.black87, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, size: 22.sp, color: Colors.black38),
                ],
              ),
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
        Text(label, style: TextStyle(fontSize: 13.5.sp, color: Colors.black87)),
        const Spacer(),
        Text(value, style: TextStyle(fontSize: 13.5.sp, color: Colors.black87)),
      ],
    );
  }
}
