// lib/feature/splash/question5.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../feature/auth/controller/auth_controller.dart';
import '../../routes/route_name.dart';
import '../../widget/auth/custom_button.dart';
import '../../widget/common/option_button.dart';

class Question5 extends StatelessWidget {
  const Question5({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    final options = [
      "Hydration",
      "Dry",
      "Firm",
      "Smooth",
      "Oily",
      "Breakout",
      "Bright",
      "Soft",
    ];

    return Scaffold(
      backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50.h),
            Text(
              "What's your top skin goal?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.sp,
                fontFamily: 'Gayathri',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "What are the top issues you'd like to improve?",
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'Gayathri',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.h),


            ...options.map((option) => Column(
              children: [
                Obx(() => OptionButton(
                  label: option,
                  isSelected: controller.skinGoal.value == option,
                  onTap: () => controller.skinGoal.value = option,
                )),
                SizedBox(height: 10.h),
              ],
            )),
            SizedBox(height: 20.h),
            CustomButton(
              text: 'Continue',
              onPressed: () => Get.toNamed(RouteName.subscription),
            ),
          ],
        ),
      ),
    );
  }
}
