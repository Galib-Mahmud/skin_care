import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincare/widget/auth/custom_appbar.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  // Define consistent text styles
  static final _titleStyle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: Colors.black87,
    height: 1.6,
  );

  static final _sectionTitleStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    height: 1.6,
  );

  static final _bodyStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
    height: 1.6,
  );

  static final _bulletStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
    height: 1.6,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Privacy"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.4),
            borderRadius: BorderRadius.circular(16.r),
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
              SizedBox(height: 8.h),

              Text(
                'Protecting Your Information',
                style: _titleStyle,
              ),
              SizedBox(height: 8.h),

              Text(
                'We respect your privacy and are committed to protecting your personal information. The Privacy Policy explains how we collect, use, and safeguard information you provide in your Profile account.',
                style: _bodyStyle,
              ),
              SizedBox(height: 16.h),

              Text('1. Information We Collect', style: _sectionTitleStyle),
              SizedBox(height: 6.h),
              Text(
                'When you create or update your profile, we may collect:',
                style: _bodyStyle,
              ),
              SizedBox(height: 6.h),

              _BulletPoint('Name, email address, and profile photo'),
              _BulletPoint('Skincare goals and choice to share preferences'),
              _BulletPoint('Other optional information (e.g., bio, preferences)'),
              SizedBox(height: 16.h),

              Text('2. How We Use Your Information', style: _sectionTitleStyle),
              SizedBox(height: 6.h),
              Text('Your information is used to:', style: _bodyStyle),
              SizedBox(height: 6.h),
              _BulletPoint('Display your profile details to you and if applicable, to other users'),
              _BulletPoint('Improve our services and personalize your experience'),
              _BulletPoint('Communicate important updates about your account or security'),
              SizedBox(height: 16.h),

              Text('3. Data Sharing', style: _sectionTitleStyle),
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

              Text('4. Data Security', style: _sectionTitleStyle),
              SizedBox(height: 6.h),
              Text(
                'We use industry-standard security measures to protect your profile information. However, no online service is completely risk-free, so please keep your login details safe.',
                style: _bodyStyle,
              ),
              SizedBox(height: 16.h),

              Text('5. Your Rights', style: _sectionTitleStyle),
              SizedBox(height: 6.h),
              Text('You can:', style: _bodyStyle),
              SizedBox(height: 6.h),
              _BulletPoint('View and update your profile information at any time'),
              _BulletPoint('Request deletion of your account and related data'),
              _BulletPoint('Contact us for any privacy-related concerns'),
              SizedBox(height: 16.h),

              Text('6. Contact Us', style: _sectionTitleStyle),
              SizedBox(height: 6.h),
              Text(
                'If you have questions about this Privacy Policy, please reach out to us at:',
                style: _bodyStyle,
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
          Text('• ', style: PrivacyScreen._bulletStyle),
          Expanded(
            child: Text(
              text,
              style: PrivacyScreen._bulletStyle,
            ),
          ),
        ],
      ),
    );
  }
}