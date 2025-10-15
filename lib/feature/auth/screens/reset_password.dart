import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skincare/routes/route_name.dart';
import '../../../widget/auth/custom_back_button.dart';
import '../../../widget/auth/custom_button.dart';
import '../../../widget/auth/custom_text_field.dart';

/// Reusable custom back button


class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    print('Login attempted with email: ${_emailController.text}');
  }

  void _navigateToSignUp() {
    print('Navigate to Sign Up screen');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                CustomBackButton(), // Back button at top-left
                const SizedBox(height: 16),
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
                        "Please enter your email to reset the password",
                        style: TextStyle(

                          fontFamily: "Inter",
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                CustomTextField(
                  icon: Icons.email,
                  labelText: 'Enter Email Address',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),

                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Reset Password',
                  onPressed: () {
                    Get.toNamed(RouteName.otpScreen);

                  },
                ),
                const SizedBox(height: 16),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
