// ─── SignUpScreen ──────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skincare/routes/route_name.dart';
import '../../../widget/auth/custom_back_button.dart';
import '../../../widget/auth/custom_button.dart';
import '../../../widget/auth/custom_text_field.dart';
import '../controller/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            const CustomBackButton(),
            Center(
              child: SizedBox(
                width: 150.w,
                height: 150.h,
                child: Image.asset('assets/images/splash/signin.png',
                    fit: BoxFit.contain),
              ),
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              icon: Icons.person,
              labelText: 'Enter Full Name',
              controller: controller.fullNameController,
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              icon: Icons.email,
              labelText: 'Enter Email Address',
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              icon: Icons.phone,
              labelText: 'Enter Mobile Number',
              controller: controller.mobileController,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              icon: Icons.lock,
              labelText: 'Enter Password',
              controller: controller.passwordController,
              obscureText: true,
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              icon: Icons.lock,
              labelText: 'Re-enter Password',
              controller: controller.rePasswordController,
              obscureText: true,
            ),
            SizedBox(height: 30.h),
            Obx(() => CustomButton(
              text: controller.isLoading.value ? 'Please wait...' : 'Sign Up',
              onPressed: controller.isLoading.value
                  ? () {}
                  : controller.register,
            )),
            CustomButton(
              text: 'Sign In',
              onPressed: () => Get.toNamed(RouteName.signin),
            ),
            SizedBox(height: 20.h),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     SizedBox(
            //       width: 120.w, height: 56.h,
            //       child: GestureDetector(
            //         onTap: () {},
            //         child: Image.asset('assets/images/auth/Google.png',
            //             fit: BoxFit.contain),
            //       ),
            //     ),
            //     SizedBox(width: 20.w),
            //     SizedBox(
            //       width: 120.w, height: 50.h,
            //       child: GestureDetector(
            //         onTap: () {},
            //         child: Image.asset('assets/images/auth/apple.png',
            //             fit: BoxFit.contain),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}