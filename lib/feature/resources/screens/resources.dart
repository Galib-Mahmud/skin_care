import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skincare/feature/resources/controller/resources_controller.dart';
import 'package:skincare/routes/route_name.dart';

class CheckinScreen2 extends StatelessWidget {
  const CheckinScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final ResourcesController resourcesController =
    Get.put(ResourcesController(), permanent: true);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 8.h),

              /// Title
              Text(
                'Resources',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),

              Text(
                'Grow in faith and wellness',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),

              SizedBox(height: 16.h),

              /// Resource Grid
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 1.2,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  _ResourceCard(
                    icon: Image.asset(
                      'assets/images/home/book.png',
                      width: 24.w,
                      height: 24.w,
                    ),
                    title: 'Skincare Guides',
                    subtitle: 'Faith-based beauty tips',
                    onTap: () => Get.toNamed(RouteName.skincareGuide),
                  ),
                  _ResourceCard(
                    icon: Image.asset(
                      'assets/images/home/love.png',
                      width: 24.w,
                      height: 24.w,
                    ),
                    title: 'Daily Devotions',
                    subtitle: 'Spiritual nourishment',
                    onTap: () => Get.toNamed(RouteName.dailyDaviation),
                  ),
                  _ResourceCard(
                    icon: Image.asset(
                      'assets/images/home/man.png',
                      width: 24.w,
                      height: 24.w,
                    ),
                    title: 'AI Recipe Generator',
                    subtitle: 'Healthy meals for glow',
                    onTap: () => Get.toNamed(RouteName.recipe),
                  ),
                  _ResourceCard(
                    icon: Image.asset(
                      'assets/images/home/add.png',
                      width: 24.w,
                      height: 24.w,
                    ),
                    title: 'Journal Prompts',
                    subtitle: 'AI-guided reflection',
                    onTap: () => Get.toNamed(RouteName.jurnalprompts),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              /// Recommended Reading Title
              Text(
                'Recommended Reading',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),

              SizedBox(height: 16.h),

              /// Recommended Reading Section
              Obx(() {
                if (resourcesController.isLoading.value) {
                  return const Center(
                    child: LinearProgressIndicator(minHeight: 2),
                  );
                }

                final reading =
                    resourcesController.recommendedReading.value;

                if (reading == null) {
                  return const SizedBox();
                }

                return Column(
                  children: [
                    if (reading.skincare != null)
                      _ReadingCard(
                        title: reading.skincare?.title ?? '',
                        content: reading.skincare?.content ?? '',
                      ),

                    SizedBox(height: 12.h),

                    if (reading.devotion != null)
                      _ReadingCard(
                        title: reading.devotion?.title ?? '',
                        content: reading.devotion?.content ?? '',
                      ),
                  ],
                );
              }),

              SizedBox(height: 80.h),
            ],
          ),
        ),
      ),
    );
  }
}

/// =========================
/// Resource Card
/// =========================

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
          color: const Color.fromRGBO(255, 255, 255, 0.4),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 0.4),
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
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
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

/// =========================
/// Reading Card
/// =========================

class _ReadingCard extends StatelessWidget {
  final String title;
  final String content;

  const _ReadingCard({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.dialog(
          AlertDialog(
            backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)),
            title: Text(
              title,
              style:
              TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Text(
                content,
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black87,
                    height: 1.6),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'Close',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ],
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.4),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(14.w),
        child: Row(
          children: [
            Container(
              width: 6.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    content,
                    style: TextStyle(
                        fontSize: 14.sp, color: Colors.black87),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}