import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skincare/routes/route_name.dart';

class CheckinScreen2 extends StatelessWidget {
  const CheckinScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E9), // mockup grey
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 8.h),
              Text(
                'Resources',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Grow in faith and wellness',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp, color: Colors.black87),
              ),
              SizedBox(height: 16.h),

              // Resource Cards Grid
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 1.2,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  _ResourceCard(
                    icon: Image.asset('assets/images/home/book.png', width: 24.w, height: 24.w),
                    title: 'Skincare Guides',
                    subtitle: 'Faith-based beauty tips',
                    onTap: () => Get.toNamed(RouteName.profileScreen),
                  ),
                  _ResourceCard(
                    icon: Image.asset('assets/images/home/love.png', width: 24.w, height: 24.w),
                    title: 'Daily Devotions',
                    subtitle: 'Spiritual nourishment',
                  ),
                  _ResourceCard(
                    icon: Image.asset('assets/images/home/man.png', width: 24.w, height: 24.w),
                    title: 'AI Recipe Generator',
                    subtitle: 'Healthy meals for glow',
                  ),
                  _ResourceCard(
                    icon: Image.asset('assets/images/home/add.png', width: 24.w, height: 24.w),
                    title: 'Journal Prompts',
                    subtitle: 'AI-guided reflection',
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // Recommended Reading
              Text(
                'Recommended Reading',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 12.h),
              const _ReadingCard(
                title: 'Managing Dry Skin in Winter',
                content:
                'Learn how to keep your skin healthy during harsh weather—honoring the temple God gave you.',
              ),
              SizedBox(height: 12.h),
              const _ReadingCard(
                title: 'Finding Rest in His Presence',
                content:
                'Devotional on finding peace and rest through faith during stressful times.',
              ),
              SizedBox(height: 80.h), // leave space above bottom bar
            ],
          ),
        ),
      ),


    );
  }
}

/// ==== Widgets ====

class _ResourceCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _ResourceCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon inside soft circle
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: icon,
            ),
            SizedBox(height: 10.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.5.sp,
                color: Colors.black54,
                height: 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _ReadingCard extends StatelessWidget {
  final String title;
  final String content;

  const _ReadingCard({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(14.w),
      child: Row(
        children: [
          // leading pill
          Container(
            width: 6.w,
            height: 42.h,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.75),
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 15.5.sp, fontWeight: FontWeight.w700)),
                SizedBox(height: 6.h),
                Text(content, style: TextStyle(fontSize: 13.sp, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


