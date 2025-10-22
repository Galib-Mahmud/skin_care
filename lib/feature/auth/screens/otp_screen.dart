import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widget/auth/custom_back_button.dart';
import '../../../widget/auth/custom_button.dart';
import 'package:skincare/routes/route_name.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _codeControllers = List.generate(
    6,
        (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _verifyCode() {
    print(
      'Verify code attempted with: ${_codeControllers.map((c) => c.text).join('')}',
    );
  }

  void _resendEmail() {
    print('Resend email requested');
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
    if (index == 5 && value.length == 1) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.w), // Responsive padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              CustomBackButton(),
              SizedBox(height: 32.h),
              Center(
                child: Image.asset(
                  'assets/images/splash/signin.png',
                  fit: BoxFit.contain,
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Check your email",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 24.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "We sent a Code to your email. Enter the 6-digit code from the email.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "Inter", fontSize: 16.sp,color: Color(0x9901031D),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w), // Scalable padding
                    child: Container(
                      width: 50.w, // Responsive width using ScreenUtil
                      height: 50.h, // Responsive height using ScreenUtil
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey[100]!,
                          width: 0.4,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _codeControllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: TextStyle(
                          fontSize: 18.sp, // Scalable font size
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15.h), // Responsive padding
                        ),
                        onChanged: (value) => _onChanged(value, index),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 40.h),
              CustomButton(
                text: 'Verify Code',
                onPressed: () {
                  Get.toNamed(RouteName.accountCreateSuccessfully);
                },
              ),
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'Haven\'t got the email yet? Resend email',
                  style: TextStyle(color: Colors.black, fontSize: 16.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
