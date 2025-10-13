import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),

          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.4),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12.h),

              Text(
                'Welcome to [Skin Care], a place where simplicity meets innovation. We are committed to building a platform that makes your digital journey smoother, safer, and more enjoyable. Whether you\'re managing your profile, staying updated with notifications, or exploring new features, everything is designed with you in mind.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 12.h),

              Text(
                'Our mission is to empower users with tools that are intuitive, secure, and reliable. Whether you\'re managing your profile, staying updated with notifications, or exploring new features, everything is designed with you in mind.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 12.h),

              Text(
                'At [Skin care], we embrace core values:',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 8.h),

              _BulletPoint('User-Centered Design – ensuring every interaction is intuitive and user-friendly'),
              _BulletPoint('Transparency – being clear and open in every step'),
              _BulletPoint('Privacy & Security – protecting your data with the highest standards'),
              _BulletPoint('Continuous Innovation – always improving, always evolving'),
              SizedBox(height: 14.h),

              Text(
                'This application is more than just software—it\'s a reflection of our commitment to your satisfaction and our dedication to enhancing your everyday experience.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 12.h),

              Text(
                'Thank you for choosing [Your App/Platform Name]. We\'re excited to have you with us on this journey, and we look forward to bringing you even more features in the future.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 12.h),

              Text(
                'Version 1.0.0\nDeveloped by [Your Team]',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black,
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

class _BulletPoint extends StatelessWidget {
  const _BulletPoint(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}