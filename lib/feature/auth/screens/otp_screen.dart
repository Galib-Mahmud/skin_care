import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skincare/routes/route_name.dart';
import '../../../widget/auth/custom_back_button.dart';
import '../../../widget/auth/custom_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _codeControllers = List.generate(6, (_) => TextEditingController());
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
    print('Verify code attempted with: ${_codeControllers.map((c) => c.text).join('')}');
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
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(

            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  CustomBackButton(),
                  const SizedBox(height: 32),
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
                          "Forgot password",
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 24.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "We sent a Code your email@dsd.com. Enter 6 digit code mentioned in the email",
                          style: TextStyle(

                            fontFamily: "Inter",
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(6, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: 50,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey[400]!, width: 2),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _codeControllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            onChanged: (value) => _onChanged(value, index),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    text: 'Verify Code',
                    onPressed: () {
                      Get.toNamed(RouteName.updatePass);
                    },
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: _resendEmail,
                    child: const Text(
                      textAlign: TextAlign.center,
                      'Haven\'t got the email yet? Resend email',
                      style: TextStyle(
                        color: Colors.black,

                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}