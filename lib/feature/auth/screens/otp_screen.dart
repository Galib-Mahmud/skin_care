// ─── OtpScreen ─────────────────────────────────────────────────────

import 'dart:async';
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

              // ── Resend with 1-min countdown ──
              _ResendEmailButton(controller: controller),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Resend Email Button with Countdown Timer ───────────────────────

class _ResendEmailButton extends StatefulWidget {
  final AuthController controller;
  const _ResendEmailButton({required this.controller});

  @override
  State<_ResendEmailButton> createState() => _ResendEmailButtonState();
}

class _ResendEmailButtonState extends State<_ResendEmailButton> {
  Timer? _timer;
  int _secondsRemaining = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 60;
      _canResend = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
        setState(() => _canResend = true);
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  void _handleResend() {
    if (!_canResend) return;

    if (widget.controller.otpFlowType.value == 'register') {
      widget.controller.resendRegistrationOtp();
    } else if (widget.controller.otpFlowType.value == 'forgot_password') {
      widget.controller.resendForgotPasswordOtp();
    }

    _startTimer(); // Reset timer after resend
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _canResend ? _handleResend : null,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 16.sp,
              color: Colors.black,
            ),
            children: [
              const TextSpan(text: "Haven't got the email yet? "),
              TextSpan(
                text: _canResend
                    ? "Resend email"
                    : "Resend email in ${_secondsRemaining}s",
                style: TextStyle(
                  color: _canResend ? Colors.black : Colors.grey,
                  decoration: _canResend
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}