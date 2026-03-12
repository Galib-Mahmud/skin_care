// lib/feature/splash/question1.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../feature/auth/controller/auth_controller.dart';
import '../../routes/route_name.dart';
import '../../widget/auth/custom_button.dart';
import '../../widget/common/option_button.dart';

class Question1 extends StatelessWidget {
  const Question1({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    final options = ["Clear", "Dry", "Oily", "Breakout"];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: Text(
                "What best describes your skin Status?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32.sp,
                  fontFamily: 'Gayathri',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              "What are the top issues you'd like to improve?",
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'Gayathri',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 35.h),
            ...options.map((option) => Column(
              children: [
                Obx(() => OptionButton(
                  label: option,
                  isSelected: controller.skinStatus.value == option,
                  onTap: () => controller.skinStatus.value = option,
                )),
                SizedBox(height: 10.h),
              ],
            )),
            SizedBox(height: 60.h),
            CustomButton(
              text: 'Continue',
              onPressed: () => Get.toNamed(RouteName.question2),
            ),
          ],
        ),
      ),
    );
  }
}