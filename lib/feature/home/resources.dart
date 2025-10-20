import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skincare/routes/route_name.dart';

class CheckinScreen2 extends StatelessWidget {
  const CheckinScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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

              Text(
                'Grow in faith and wellness',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22.sp, color: Colors.black,fontWeight: FontWeight.w700),
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
                    onTap: () => Get.toNamed(RouteName.skincareGuide),
                  ),
                  _ResourceCard(
                    icon: Image.asset('assets/images/home/love.png', width: 24.w, height: 24.w),
                    title: 'Daily Devotions',
                    subtitle: 'Spiritual nourishment',
                    onTap: () => Get.toNamed(RouteName.dailyDaviation),
                  ),
                  _ResourceCard(
                    icon: Image.asset('assets/images/home/man.png', width: 24.w, height: 24.w),
                    title: 'AI Recipe Generator',
                    subtitle: 'Healthy meals for glow',
                    onTap: () => Get.toNamed(RouteName.recipe),
                  ),
                  _ResourceCard(
                    icon: Image.asset('assets/images/home/add.png', width: 24.w, height: 24.w),
                    title: 'Journal Prompts',
                    subtitle: 'AI-guided reflection',
                    onTap: () => Get.toNamed(RouteName.jurnalprompts),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // Recommended Reading
              Text(
                'Recommended Reading',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 18.h),
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
          color:  Color.fromRGBO(255, 255, 255, 0.4),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon inside soft circle
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.4),
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
            SizedBox(height: 20.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
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
        color: Color.fromRGBO(255, 255, 255, 0.4),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset:  Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(14.w),
      child: Row(
        children: [
          // leading pill
          Container(
            width: 6.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.75),
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 6.h),
                Text(content, style: TextStyle(fontSize: 14.sp, color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


