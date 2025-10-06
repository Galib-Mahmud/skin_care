import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({
    super.key,
    this.eta = '30mins',
    this.addressLabel = 'Home',
    this.amount = 32.12,
    this.onClose,
    this.onTrack,
  });

  final String eta;
  final String addressLabel;
  final double amount;
  final VoidCallback? onClose;
  final VoidCallback? onTrack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),

      // custom header (X at left)
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.h),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: onClose ?? () => Navigator.maybePop(context),
                borderRadius: BorderRadius.circular(999),
                child: Padding(
                  padding: EdgeInsets.all(6.w),
                  child: Icon(Icons.close, size: 20.sp, color: Colors.black87),
                ),
              ),
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          SizedBox(height: 12.h),

          // check in circle
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Icon(Icons.check, size: 28.sp, color: Colors.black87),
          ),
          SizedBox(height: 18.h),

          // headline (two lines)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Yay! Your order\nhas been placed.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22.sp,
                height: 1.2,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(height: 10.h),

          // small grey description (two lines)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Your order would be delivered in the\n30 mins atmost',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.5.sp,
                height: 1.35,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 22.h),

          // info rows
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                _InfoRow(
                  icon: Icons.access_time,
                  label: 'Estimated time',
                  value: eta,
                ),
                SizedBox(height: 12.h),
                _InfoRow(
                  icon: Icons.location_on_outlined,
                  label: 'Deliver to',
                  value: addressLabel,
                ),
                SizedBox(height: 12.h),
                _InfoRow(
                  icon: Icons.credit_card,
                  label: 'Amount Paid',
                  value: '\$${amount.toStringAsFixed(2)}',
                ),
              ],
            ),
          ),

          const Spacer(),

          // bottom CTA
          SafeArea(
            top: false,
            minimum: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 14.h),
            child: SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  elevation: 0,
                ),
                onPressed: onTrack ?? () {},
                child: Text(
                  'Track my order',
                  style: TextStyle(fontSize: 14.5.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: Colors.black54),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.5.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.5.sp,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
