import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FullStoryScreen extends StatelessWidget {
  const FullStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Full Story',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
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
              // Header with name and timestamp
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Maria S.',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '1 week ago',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // Title
              Text(
                '6 Months of Faith & Clear Skin',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12.h),

              // Full story content
              Text(
                'Through prayer, patience, and gentle skincare, God has blessed me with the confidence I never thought I\'d have!\n\n'
                    'Through prayer, patience, and gentle skincare, God has blessed me with the confidence I never thought I\'d have!\n\n'
                    'Through prayer, patience, and gentle skincare, God has blessed me with the confidence I never thought I\'d have!\n\n'
                    'Through prayer, patience, and gentle skincare, God has blessed me with the confidence I never thought I\'d have!\n\n'
                    'Through prayer, patience, and gentle skincare, God has blessed me with the confidence I never thought I\'d have!\n\n'
                    'Through prayer, patience, and gentle skincare, God has blessed me with the confidence I never thought I\'d have!\n\n'
                    'Through prayer, patience, and gentle skincare, God has blessed me with the confidence I never thought I\'d have!',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}