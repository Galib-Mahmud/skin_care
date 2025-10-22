import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skincare/routes/route_name.dart';

class DailyFaithScreen extends StatelessWidget {
  const DailyFaithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF9A9A9A),
          ),

        child: Column(
          children: [
            // Top image section
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                    child: Image.asset(
                      'assets/images/splash/Vector 3.png',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            // Text content
            Padding(
              padding: EdgeInsets.only(left: 20.w,bottom: 20.h),
              child: Row(
                children: [
                  Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.start,
                        'Daily Faith ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 29.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        textAlign: TextAlign.start,
                        'Smarter Listings, Faster Sales.',
                        style: TextStyle(

                          color: Colors.white,
                          fontSize: 16.sp,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Next Button at bottom right
            Padding(
              padding: EdgeInsets.only(bottom: 30.h, right: 30.w),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 49.h,
                  width: 115.w,
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8.r,
                        offset: Offset(0, 3.h),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(RouteName.skinCare);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Rubik',
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}