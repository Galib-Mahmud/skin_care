// lib/feature/splash/question3.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../feature/auth/controller/auth_controller.dart';
import '../../routes/route_name.dart';
import '../../widget/auth/custom_button.dart';
import '../../widget/common/option_button.dart';

class Question3 extends StatelessWidget {
  const Question3({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final options = ["Struggling😞", "Okay 😕", "Good 😊", "Great 😄", "Blessed 🙏"];

    return Scaffold(
      backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "How are you feeling today?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.sp,
                fontFamily: 'Gayathri',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
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
                  isSelected: controller.feeling.value == option,
                  onTap: () => controller.feeling.value = option,
                )),
                SizedBox(height: 10.h),
              ],
            )),
            SizedBox(height: 60.h),
            CustomButton(
              text: 'Continue',
              onPressed: () => Get.toNamed(RouteName.question4),
            ),
          ],
        ),
      ),
    );
  }
}