import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../routes/route_name.dart';
import '../../../../widget/auth/custom_appbar.dart';

class ScreenCareGuide extends StatelessWidget {
  const ScreenCareGuide({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: ''),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),
              // Headline
              Text(
                "Hello! How can I assist you\ntoday?",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  height: 1.25,
                ),
              ),
              SizedBox(height: 10.h),

              // Subtext
              Text(
                "Instant answers at your fingertips!",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontFamily: "Playfair Display"
                ),
              ),

              // Illustration + avatars chip
              Expanded(
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Illustration (replace with your asset)
                      Image.asset(
                        'assets/images/home/skincareguide.png',
                        width: 270.w,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),

              // Big outlined circular confirm button
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteName.jurnalChatBot,
                    arguments: "skincare",
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 100.h),
                  child: Center(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(1000.r),
                      child: Container(
                        width: 70.w,
                        height: 70.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black, // inner dark circle
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // white ring outline
                            Container(
                              width: 70.w,
                              height: 70.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 3),
                              ),
                            ),
                            Icon(Icons.check, color: Colors.white, size: 28.sp),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
