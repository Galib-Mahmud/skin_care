import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _dailyCheckIn = true;
  bool _waterIntake = false;
  bool _dailyDevotional = false;
  bool _productRecommendations = true;
  bool _communityUpdates = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: SafeArea(
          bottom: false,
          child: Center(
            child: Text(
              'Notification',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification Settings Header Card
            Container(
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
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_outlined,
                        size: 22.sp,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Notification Settings',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),



                  SizedBox(height: 12.h),

                  _NotificationTile(
                    title: 'Water Intake Reminders',
                    subtitle: 'Stay hydrated throughout the day',
                    value: _waterIntake,
                    onChanged: (value) {
                      setState(() {
                        _waterIntake = value;
                      });
                    },
                  ),

                  SizedBox(height: 12.h),

                  _NotificationTile(
                    title: 'Daily Devotional',
                    subtitle: 'Get reminded to log your daily skincare',
                    value: _dailyDevotional,
                    onChanged: (value) {
                      setState(() {
                        _dailyDevotional = value;
                      });
                    },
                  ),

                  SizedBox(height: 12.h),

                  _NotificationTile(
                    title: 'Product Recommendations',
                    subtitle: 'Personalized skincare suggestions',
                    value: _productRecommendations,
                    onChanged: (value) {
                      setState(() {
                        _productRecommendations = value;
                      });
                    },
                  ),

                  SizedBox(height: 12.h),

                  _NotificationTile(
                    title: 'Community Updates',
                    subtitle: 'New prayer requests and encouragements',
                    value: _communityUpdates,
                    onChanged: (value) {
                      setState(() {
                        _communityUpdates = value;
                      });
                    },
                  ),


                ],

              ),


            ),

            SizedBox(height: 16.h),









          ],
        ),
      ),
    );
  }
}

/// --- Notification Tile Widget ---
class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final Function(bool) onChanged;

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
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black54,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.black87,
            activeTrackColor: Colors.black54,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.black26,
          ),
        ],
      ),
    );
  }
}