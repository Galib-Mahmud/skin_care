// ─── SignInScreen ──────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skincare/routes/route_name.dart';
import '../../../widget/auth/custom_back_button.dart';
import '../../../widget/auth/custom_button.dart';
import '../../../widget/auth/custom_text_field.dart';
import '../controller/auth_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                const CustomBackButton(),
                SizedBox(height: 16.h),
                Center(
                  child: Image.asset('assets/images/splash/signin.png',
                      width: 200.w, height: 200.h, fit: BoxFit.contain),
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Welcome Back!",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Log in to discover your perfect match",
                        style:
                        TextStyle(fontFamily: "Inter", fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 22.h),
                CustomTextField(
                  icon: Icons.email,
                  labelText: 'Enter Email Address',
                  controller: controller.signInEmailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  icon: Icons.lock,
                  labelText: 'Enter Password',
                  controller: controller.signInPasswordController,
                  obscureText: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Get.toNamed(RouteName.resetPass),
                    child: const Text('Forgot Password?',
                        style: TextStyle(color: Color(0xFF555555))),
                  ),
                ),
                SizedBox(height: 16.h),
                Obx(() => CustomButton(
                  text: controller.isLoading.value ? 'Please wait...' : 'Sign In',
                  onPressed: controller.isLoading.value
                      ? () {}
                      : controller.login,
                )),
                CustomButton(
                  text: 'Sign Up',
                  onPressed: () => Get.toNamed(RouteName.signup),
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
        ),
      ),
    );
  }
}