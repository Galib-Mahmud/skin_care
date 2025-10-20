import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skincare/routes/route_name.dart';

class OrderFailedScreen extends StatelessWidget {
  const OrderFailedScreen({
    super.key,
    this.title =
    'Sorry, your order could\nnot be placed.',
    this.subtitle =
    'Something went wrong. Please try again or\ncontact support for assistance.',
    this.onClose,
    this.onReorder,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onClose;
  final VoidCallback? onReorder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    

      // top-left close icon
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
                  child: Icon(Icons.close, size: 24.sp, color: Colors.black87),
                ),
              ),
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          SizedBox(height: 100.h),

          // red circle with white X
          Container(
            width: 56.w,
            height: 56.w,
            decoration: const BoxDecoration(
              color: Color(0xFFFF3B57), // vivid red like mock
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.close_rounded, size: 30.sp, color: Colors.white),
          ),
          SizedBox(height: 22.h),

          // headline
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.sp,

                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(height: 10.h),

          // helper text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                height: 1.35,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

         Spacer(),

          // bottom CTA
          SafeArea(
            top: false,
            minimum: EdgeInsets.only(left: 16.w, right: 16, bottom: 140.h),
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
                onPressed: onReorder ?? () {
                  Get.toNamed(RouteName.homeScreen);
                },
                child: Text(
                  'Re Order',
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
