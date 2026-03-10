// lib/feature/profile/screen/notification_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widget/auth/custom_appbar.dart';
import '../controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();

    return Scaffold(
      appBar: CustomAppBar(title: 'Notifications'),  // ← replaced
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.black));
        }
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.notifications_outlined,
                        size: 22.sp, color: Colors.black87),
                    SizedBox(width: 12.w),
                    Text(
                      'Notification Settings',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87),
                    ),
                    const Spacer(),
                    Obx(() => controller.isSaving.value
                        ? SizedBox(
                      width: 18.w,
                      height: 18.h,
                      child: const CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.black54),
                    )
                        : const SizedBox.shrink()),
                  ],
                ),
                SizedBox(height: 16.h),
                _NotificationTile(
                  title: 'Daily Check-in Reminder',
                  subtitle: 'Get reminded to complete your daily check-in',
                  value: controller.dailyCheckIn,
                  onChanged: (_) => controller.toggle(controller.dailyCheckIn),
                ),
                SizedBox(height: 12.h),
                _NotificationTile(
                  title: 'Water Intake Reminders',
                  subtitle: 'Stay hydrated throughout the day',
                  value: controller.waterIntake,
                  onChanged: (_) => controller.toggle(controller.waterIntake),
                ),
                SizedBox(height: 12.h),
                _NotificationTile(
                  title: 'Daily Devotional',
                  subtitle: 'Get reminded to log your daily skincare',
                  value: controller.dailyDevotional,
                  onChanged: (_) =>
                      controller.toggle(controller.dailyDevotional),
                ),
                SizedBox(height: 12.h),
                _NotificationTile(
                  title: 'Product Recommendations',
                  subtitle: 'Personalized skincare suggestions',
                  value: controller.productRecommendations,
                  onChanged: (_) =>
                      controller.toggle(controller.productRecommendations),
                ),
                SizedBox(height: 12.h),
                _NotificationTile(
                  title: 'Community Updates',
                  subtitle: 'New prayer requests and encouragements',
                  value: controller.communityUpdates,
                  onChanged: (_) =>
                      controller.toggle(controller.communityUpdates),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final RxBool value;
  final Function(bool) onChanged;

  const _NotificationTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87)),
                SizedBox(height: 4.h),
                Text(subtitle,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black54,
                        height: 1.3)),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Obx(() => Switch(
            value: value.value,
            onChanged: onChanged,
            activeColor: Colors.black87,
            activeTrackColor: Colors.black54,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.black26,
          )),
        ],
      ),
    );
  }
}