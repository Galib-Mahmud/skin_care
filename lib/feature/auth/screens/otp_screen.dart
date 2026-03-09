// ─── OtpScreen ─────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widget/auth/custom_back_button.dart';
import '../../../widget/auth/custom_button.dart';
import '../controller/auth_controller.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              const CustomBackButton(),
              SizedBox(height: 32.h),
              Center(
                child: Image.asset('assets/images/splash/signin.png',
                    fit: BoxFit.contain),
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Check your email",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "We sent a code to your email. Enter the 6-digit code.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16.sp,
                          color: const Color(0x9901031D)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),

              // OTP fields
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: controller.otpControllers[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 15.h),
                        ),
                        onChanged: (value) {
                          if (value.length == 1 && index < 5) {
                            FocusScope.of(context).nextFocus();
                          } else if (value.isEmpty && index > 0) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 40.h),

              Obx(() => CustomButton(
                text: controller.isLoading.value
                    ? 'Verifying...'
                    : 'Verify Code',
                onPressed: controller.isLoading.value
                    ? () {}
                    : controller.verifyOtp,
              )),
              SizedBox(height: 20.h),

              Center(
                child: GestureDetector(
                  onTap: () {
                    if (controller.otpFlowType.value == 'register') {
                      controller.resendRegistrationOtp();
                    } else {
                      controller.resendForgotPasswordOtp();
                    }
                  },
                  child: Text(
                    "Haven't got the email yet? Resend email",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}