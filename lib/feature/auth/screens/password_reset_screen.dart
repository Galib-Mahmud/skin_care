// ─── PasswordResetScreen (Set new password) ────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widget/auth/custom_back_button.dart';
import '../../../widget/auth/custom_button.dart';
import '../../../widget/auth/custom_text_field.dart';
import '../controller/auth_controller.dart';

class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

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
                      fit: BoxFit.contain),
                ),
                Center(
                  child: Text(
                    "Password Reset",
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 24.h),
                CustomTextField(
                  icon: Icons.lock,
                  labelText: 'Enter New Password',
                  controller: controller.newPasswordController,
                  obscureText: true,
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  icon: Icons.lock,
                  labelText: 'Re-Enter New Password',
                  controller: controller.confirmNewPasswordController,
                  obscureText: true,
                ),
                SizedBox(height: 24.h),
                Obx(() => CustomButton(
                  text: controller.isLoading.value
                      ? 'Updating...'
                      : 'Update Password',
                  onPressed: controller.isLoading.value
                      ? () {}
                      : controller.setNewPassword,
                )),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}