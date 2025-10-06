import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

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
                'Privacy',
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
              Text(
                'Privacy',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),

              Text(
                'Protecting Your Information',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),

              Text(
                'We respect your privacy and are committed to protecting your personal information. The Privacy Policy explains how we collect, use, and safeguard information you provide in your Profile account.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 16.h),

              Text(
                '1. Information We Collect',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 6.h),

              Text(
                'When you create or update your profile, we may collect:',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 6.h),

              _BulletPoint('Name, email address, and profile photo'),
              _BulletPoint('Skincare goals and choice to share preferences'),
              _BulletPoint('Other optional information (e.g., bio, preferences)'),
              SizedBox(height: 16.h),

              Text(
                '2. How We Use Your Information',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 6.h),

              Text(
                'Your information is used to:',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 6.h),

              _BulletPoint('Display your profile details to you and if applicable, to other users'),
              _BulletPoint('Improve our services and personalize your experience'),
              _BulletPoint('Communicate important updates about your account or security'),
              SizedBox(height: 16.h),

              Text(
                '3. Data Sharing',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 6.h),

              _BulletPoint('We do not sell your personal information.'),
              _BulletPoint('We may share data with:'),
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _BulletPoint('Service providers who help us operate the app (subject to strict confidentiality)'),
                    _BulletPoint('Authorities, if required by law or to protect our users\' safety'),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              Text(
                '4. Data Security',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 6.h),

              Text(
                'We use industry-standard security measures to protect your profile information. However, no online service is completely risk-free, so please keep your login details safe.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 16.h),

              Text(
                '5. Your Rights',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 6.h),

              Text(
                'You can:',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 6.h),

              _BulletPoint('View and update your profile information at any time'),
              _BulletPoint('Request deletion of your account and related data'),
              _BulletPoint('Contact us for any privacy-related concerns'),
              SizedBox(height: 16.h),

              Text(
                '6. Contact Us',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 6.h),

              Text(
                'If you have questions about this Privacy Policy, please reach out to us at:',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 6.h),

              _BulletPoint('[support email@example.com]'),
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